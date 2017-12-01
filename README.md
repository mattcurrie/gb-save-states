# gb-save-states
Patches to add save state support to Game Boy games when playing on the original hardware.

# How to use

## Requirements

- Flash cart that supports 32KB of save RAM and MBC 1/5 mapper.
- Original ROM file for the game.

## Setup

1. Find some patching software that supports bsdiff patches:

   - Windows (command line) - [BsPatch](https://www.romhacking.net/utilities/929/)
   - macOS (GUI) - [Multi Patch](http://projects.sappharad.com/tools/multipatch.html)
   - macOS (terminal) - install [Homebrew](https://brew.sh/) and then run ```brew install bsdiff``` in the terminal

2. Download the .bsdiff patch file for the game from the [patches](https://github.com/mattcurrie/gb-save-states/tree/master/patches) directory


3. Patch your original ROM with the patch to build a new patched ROM. 

   Example for command line/terminal:

   ```
   bspatch "B.C. Kid (E) [!].gb" patched.gb "B.C. Kid (E) [!].gb.bsdiff"
   ```

4. Copy the patched ROM to your flash cartridge


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

If you have a bit of Game Boy assembly knowledge then you can create a patch yourself.  Documentation coming soon.

# Limitations

- Sound/Music cannot always be restored 100% due to some sound registers being read only. This generally isn't a problem unless loading a save game from the startup menu instead of during gameplay.  Pausing and resuming the game can sometimes resolve any sound problems.

The patches are currently written to target a flash cart with 32KB of save RAM, so there are the following limitations:

- Game Boy Color games are not supported.
- Games that originally use more than 8KB of battery backed RAM are not currently supported.
