IF DEF(is_cgb)
; CGB requires 128 KB
DEF RAMSIZE EQU 4
ELSE
    IF DEF(current_sram_bank)
        ; 32 KB SRAM games require 128 KB SRAM
        DEF RAMSIZE EQU 4
    ELSE
        DEF RAMSIZE EQU 3
    ENDC
ENDC

DEF ram_access_toggle EQU $0000
DEF ram_bank_select EQU $4000

DEF vram_save EQU $A000

DEF bg_color_pal_save EQU $BD00
DEF obj_color_pal_save EQU $BD40

DEF io_save EQU $BE00               ; must be 256 byte EQU aligned

; 160 bytes
DEF oam_save EQU $BF00              ; must be 256 byte EQU aligned



DEF internal_stack_pointer_save EQU $BFDE
DEF stack_pointer_save EQU $BFE0
DEF magic_byte_save EQU $BFE2

; required by packbits library 
DEF PACKBITS_INPUT_END_ADDRESS EQU $BFE4
DEF PACKBITS_CURRENT_OUTPUT_ADDRESS EQU $BFE6


; stack starts at the top of the save ram - only need about 10 bytes
DEF working_stack_pointer_address EQU $C000


DEF magic_byte_value EQU $69


IF DEF(is_cgb)
    ; this is where we put the working stack for the save state,
    ; and any I/O register values, colour palettes, etc
    SAVE_STATE_RAM_BANK:
    DB 4

    DEF save_state_vram_bank_0 EQU 5
    DEF save_state_vram_bank_1 EQU 6
    DEF save_state_wram_bank_01 EQU 7
    DEF save_state_wram_bank_23 EQU 8
    DEF save_state_wram_bank_45 EQU 9
    DEF save_state_wram_bank_67 EQU 10

    SAVE_STATE_SRAM_BANK_0:
    DB 11

    DEF save_state_sram_bank_1 EQU 12
    DEF save_state_sram_bank_2 EQU 13
    DEF save_state_sram_bank_3 EQU 14

ELSE

    RAM_SHARING_MAGIC_BYTES:
    DB "SRAM_CFG"

    IF DEF(game_uses_save_ram)

        IF DEF(current_sram_bank)
            ; game uses 32KB of SRAM

            ; this is where we put the working stack for the save state,
            ; and any I/O register values, colour palettes, etc
            SAVE_STATE_RAM_BANK:
            DB 4

            SAVE_STATE_RAM_BANK_VRAM:
            DB 5

            SAVE_STATE_SRAM_BANK_0:
            DB 11

            DEF save_state_sram_bank_1 EQU 12
            DEF save_state_sram_bank_2 EQU 13
            DEF save_state_sram_bank_3 EQU 14

        ELSE
            ; game uses 8KB of SRAM

            NUMBER_OF_BANKS:
                DB 4
            GAME_SRAM:
                DB 0
            SAVE_STATE_SRAM_BANK_0:
                DB 1
            SAVE_STATE_RAM_BANK_VRAM:
                DB 2
            SAVE_STATE_RAM_BANK:
                DB 3

        ENDC

    ELSE
        NUMBER_OF_BANKS:
            DB 2
        SAVE_STATE_RAM_BANK_VRAM:
            DB 2
        SAVE_STATE_RAM_BANK:
            DB 3
    ENDC

    SAVE_STATE_PATCH_MAGIC_BYTES:
    DB "SSPMB"
ENDC
