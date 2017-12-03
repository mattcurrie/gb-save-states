# How to create a patch for a new game

## Requirements

- Linux or macOS platform
- Some Game Boy assembly knowledge
- Game Boy emulator with debugger: [BGB](http://bgb.bircd.org/) - works great with Wine (or Wineskin on macOS) 
- Game Boy Assembler - [WLA DX](https://github.com/vhelin/wla-dx) (wla-gb and wlalink expected to be found in your path)
  - macOS: Install Homebrew and then run ```brew install cmake``` if you don't ready have it. Then follow the instructions in WLA DX's [INSTALL](https://github.com/vhelin/wla-dx/blob/master/INSTALL) file to create the make files and install in /usr/local/bin
- bsdiff command line patching tool (expected to be found in your path). 
  - macOS: Install Homebrew and then run ```brew install bsdiff``` in the terminal
- Hex editor 
  - macOS: [Hex Fiend](https://github.com/ridiculousfish/HexFiend/releases) is free and pretty good

## Process

The process below is for a standard game.  Some games might be a bit more complicated if they use non-standard joypad read functions.  If you run into one of these games, or have any other questions, create an issue and I'll try to help.


1. Go into the ```/src``` directory of the project and run the init patch script, passing in the ROM you want to patch. If the ROM is not already in the ```/original-roms``` directory then it will be copied there for you.

   ```./init-patch ~/game.gb```

   The script will create a file in the ```/src``` directory with the name of the ROM file with ```.s``` appended.

2. Open the original ROM in BGB emulator.

3. Next we need to check if the game resets the internal RAM when it starts up. In BGB add a write access breakpoint for `C300-C500` and reset the game.  Hopefully the breakpoint will be triggered inside a function that resets all of the internal RAM.  If so, you can delete the reset ram section from the patch file, and delete the ```.INCLUDE "includes/reset_ram.s"``` directive.

   If the game doesn't reset the RAM itself, then the ROM patch needs to do it. This is so that the PackBits RLE will be able to compress the internal RAM efficiently.  Check that the game jumps to ```$0150``` from ```$0101```.  If not then update the ```RESET_RAM_DONE``` define to set the correct address.  You will also need the ```.INCLUDE "includes/reset_ram.s"``` directive somewhere in bank 0. There is often space between ```$0080``` and ```$0100```, so the template includes reset_ram.s in the "relocated read from joypad" section by default.
  
4. Delete the write access breakpoint and create a new one for writes in the ```2000-3FFF``` range. This will cause the debugger to stop when a new ROM bank is selected.  

   Games will generally write the bank that is being selected to an address in RAM and then write to ```$2000``` to select the bank.  If the selected ROM bank isn't saved in RAM anywhere then it might be at ```$4000``` or ```$7fff``` in the data of each ROM bank.

   Update the value in the config section of your patch file:
    
   ```.DEFINE current_rom_bank $xxxx```

5. Delete the previous write access breakpoint and create a new one for writes with a value of ```20``` to ```FF00```.  The debugger will stop during the joypad read routine.

6. The ```joypad``` and ```joypad_2``` values are the addresses where the joypad data is stored.  You can generally find it at the end of the joypad read function. Update the values in the config section of your patch file:

    ```
    .DEFINE joypad $tttt
    .DEFINE joypad_2 $ssss
    ```

7. The joypad read routine usually writes ```$20``` to ```$FF00``` then does a ```swap a``` (or sometimes a set of four ```rrc a``` operations) before writing ```$10``` to ```$FF00```.  If not, try adding this define to the config section:

    ```
    .DEFINE swap_joypad 1
    ```

8. Also in the joypad read routine it usually does ```ld a, $30 | ldh ($00),a | ret```. Locate the start address of these instructions, and set the .ORG directive in the "joypad read" section to the address of the ```ld a, $30``` instruction.

9. Locate about 64 ($40) bytes of free space in bank 0 of the ROM for the "relocated read from joypad" section. Update the .ORG directive (and SIZE if necessary). There is often space between $0080 and $0100, so the template locates the "relocated read from joypad" at $0080 by default.

   If there isn't space available in bank 0 and the game uses a standard joypad read function, then you can overwrite the joypad function with a call to our own joypad read function in a different bank. The .ORG value from step 8 and SIZE will need to be updated to point to the start of the original joypad read function and the size of the original joypad read function.  Change the joypad read section to do this:

   ```
   .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
   ret
   ```

   and then add the joypad read and check into save/load state section:

   ```.INCLUDE "includes/joypad_read_and_check.s"```

   See the Speedball 2 patch for an example.

10. Locate approx 544 ($220) bytes of free space in the ROM.  Its usually easiest to do this in a hex editor. Then update the .BANK, .ORG, and .SECTION size defines in the save/load state section. 

    The .BANK value = ```(the start address of the free space in the ROM file) / $4000```

    The .ORG value = ```(the start address of the free space in the ROM file) AND $3fff```
	
	  The SIZE value = ```The amount of free space available```


    If there is not enough free space in the ROM then you will need to add a new bank at the end of the rom.  This has the downside of doubling the ROM size, so you will also need to double the ```.ROMBANKS``` directive.  If the current rom bank is stored in the ROM data then you will need to define that for your new ROM bank also.  See the Pop 'N TwinBee patch for an example.


11. If the game already supports games saves itself and uses 8KB of SRAM, then add this define in the config section:

    ```
    .DEFINE game_uses_save_ram 1
    ```

    Games that already use 32 KB of SRAM are not currently supported.

12. Run the script to create the patch from the ```/src``` directory.

    e.g. ```./create-bsdiff-patch game.gb.s```

	  The patched ROM will be stored in the ```/patched-roms``` directory and the .bsdiff patch file will be stored in the ```/patches``` directory.

13. Check if the game uses the wave pattern RAM by loading up the game in BGB and then save a game state during gameplay.  Then reset the emulator and try to load up the save state as soon as possible after booting.  If the sound/music sounds strange then it is likely due to the wave pattern RAM not being saved.  

    Making the wave pattern RAM readable requires disabling the third sound channel, so the third sound channel needs to be enabled again after saving/loading a save state.  This is done through the NR 34 sound register located at ```$FF1E```.  

    Set a write access breakpoint in BGB during gameplay for address ```FF1E``` and locate which address contains the data that is written to ```$FF1E```.  Add a define with the address to the config section:

    ```
    .DEFINE current_nr34_value $zzzz
    ```

    If you cannot locate the address where the current value for the NR34 register is stored, you can try just adding this define to the config section, though results may vary:

    ```
    .DEFINE restore_wave_ram 1
    ```
    
    Create the patch again and test the sound.

14. You're done! Create a pull request to add it to the repo so everyone else can enjoy it too.
