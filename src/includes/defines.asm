.EMPTYFILL $FF

.IFNDEF uses_mbc5
    .CARTRIDGETYPE 3
.ELSE
    .CARTRIDGETYPE $1B
.ENDIF


.IFDEF is_cgb
; CGB requires 128 KB
.RAMSIZE 4
.ELSE
    .IFDEF current_sram_bank
        ; 32 KB SRAM games require 128 KB SRAM
        .RAMSIZE 4
    .ELSE
        .RAMSIZE 3
    .ENDIF
.ENDIF

.COMPUTECHECKSUM
.COMPUTECOMPLEMENTCHECK



.DEFINE ram_access_toggle $0000
.DEFINE ram_bank_select $4000

.DEFINE vram_save $A000

.DEFINE bg_color_pal_save $BD00
.DEFINE obj_color_pal_save $BD40

.DEFINE io_save $BE00               ; must be 256 byte aligned

; 160 bytes
.DEFINE oam_save $BF00              ; must be 256 byte aligned



.DEFINE internal_stack_pointer_save $BFDE
.DEFINE stack_pointer_save $BFE0
.DEFINE magic_byte_save $BFE2

; required by packbits library 
.DEFINE PACKBITS_INPUT_END_ADDRESS $BFE4
.DEFINE PACKBITS_CURRENT_OUTPUT_ADDRESS $BFE6


; stack starts at the top of the save ram - only need about 10 bytes
.DEFINE working_stack_pointer_address $C000


.DEFINE magic_byte_value $69


.IFDEF is_cgb
    ; this is where we put the working stack for the save state,
    ; and any I/O register values, colour palettes, etc
    SAVE_STATE_RAM_BANK:
    .DB 4

    .DEFINE save_state_vram_bank_0 5
    .DEFINE save_state_vram_bank_1 6
    .DEFINE save_state_wram_bank_01 7
    .DEFINE save_state_wram_bank_23 8
    .DEFINE save_state_wram_bank_45 9
    .DEFINE save_state_wram_bank_67 10

    SAVE_STATE_SRAM_BANK_0:
    .DB 11

    .DEFINE save_state_sram_bank_1 12
    .DEFINE save_state_sram_bank_2 13
    .DEFINE save_state_sram_bank_3 14

.ELSE

    RAM_SHARING_MAGIC_BYTES:
    .DB "SRAM_CFG"

    .IFDEF game_uses_save_ram

        .IFDEF current_sram_bank
            ; game uses 32KB of SRAM

            ; this is where we put the working stack for the save state,
            ; and any I/O register values, colour palettes, etc
            SAVE_STATE_RAM_BANK:
            .DB 4

            SAVE_STATE_RAM_BANK_VRAM:
            .DB 5

            SAVE_STATE_SRAM_BANK_0:
            .DB 11

            .DEFINE save_state_sram_bank_1 12
            .DEFINE save_state_sram_bank_2 13
            .DEFINE save_state_sram_bank_3 14

        .ELSE
            ; game uses 8KB of SRAM

            NUMBER_OF_BANKS:
                .DB 4
            GAME_SRAM:
                .DB 0
            SAVE_STATE_SRAM_BANK_0:
                .DB 1
            SAVE_STATE_RAM_BANK_VRAM:
                .DB 2
            SAVE_STATE_RAM_BANK:
                .DB 3

        .ENDIF

    .ELSE
        NUMBER_OF_BANKS:
            .DB 2
        SAVE_STATE_RAM_BANK_VRAM:
            .DB 2
        SAVE_STATE_RAM_BANK:
            .DB 3
    .ENDIF

    SAVE_STATE_PATCH_MAGIC_BYTES:
    .DB "SSPMB"
.ENDIF

