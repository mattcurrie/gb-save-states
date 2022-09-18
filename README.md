# gb-save-states
Patches to add save state support to Game Boy and Game Boy Color games when playing on the original hardware.

# How to use

## Requirements

- For Game Boy games:
   - Flash cart that supports 32KB of save RAM and MBC 1/5 mapper
- For Game Boy Color games, and Game Boy games that originally include save RAM:
   - Flash cart that supports 128KB of save RAM and MBC 5 mapper, e.g. EZ Flash Jr. or EverDrive-GB X3/X5/X7. Not sure how much save RAM your flash cart supports? [Try this test ROM on your flash cart.](https://github.com/eievui5/sram128/releases/tag/v1.0.1)
- Original ROM file for the game
- Patching software that supports bsdiff patches:

   - Windows (command line) - [BsPatch](https://www.romhacking.net/utilities/929/)
   - macOS (GUI) - [Multi Patch](http://projects.sappharad.com/tools/multipatch.html)
   - macOS (terminal) - install [Homebrew](https://brew.sh/) and then run ```brew install bsdiff``` in the terminal


## Setup
 
1. Download the .bsdiff patch file for the game from the [patches](patches) directory


2. Patch your original ROM with the patch to build a new patched ROM. 

   Example for command line/terminal:

   ```
   bspatch "B.C. Kid (E) [!].gb" patched.gb "B.C. Kid (E) [!].gb.bsdiff"
   ```

3. Copy the patched ROM to your flash cartridge


## Controls

Due to different button layouts on the GB/GBC and the GBA, there are two different button combinations that can be used to save/load a game.  

After pressing the button combo, the screen will flash as the save/load process runs.


### Save 

Combo 1: Hold ```Down``` and press ```Start```

Combo 2: Hold ```Select``` and press ```A```

### Load

Combo 1: Hold ```Up``` and press ```Start```

Combo 2: Hold ```Select``` and press ```B```

# There isn't a patch for my favourite game!

Submit an [issue](https://github.com/mattcurrie/gb-save-states/issues) and hopefully someone will create a patch for you.

If you have a bit of Game Boy assembly knowledge then you can create a patch yourself.  [Check out the How To document](src/HOW-TO.md)

# Limitations

- Sound/Music cannot always be restored 100% due to some sound registers being read only. This generally isn't a problem unless loading a save game from the startup menu instead of during gameplay.  Pausing and resuming the game can sometimes resolve any sound problems.

# Notes

- Kirby's Dream Land uses `Select + Down + B` and `Select + Up + A` to access hidden features on the title screen. To avoid conflicts with the save/load combos, these hidden feature combos have been remapped to `Down + B` and `Up + A`.
