.EMPTYFILL $FF

.CARTRIDGETYPE 3
.RAMSIZE 3
.COMPUTECHECKSUM
.COMPUTECOMPLEMENTCHECK



.DEFINE ram_access_toggle $0000
.DEFINE ram_bank_select $4000

.DEFINE vram_save $A000
.DEFINE io_save $BE00

; 160 bytes
.DEFINE oam_save $BF00



.DEFINE stack_pointer_save $BFE0
.DEFINE magic_byte_save $BFE2

; required by packbits library 
.DEFINE PACKBITS_INPUT_END_ADDRESS $BFE4
.DEFINE PACKBITS_CURRENT_OUTPUT_ADDRESS $BFE6


; stack starts at the top of the save ram - only need about 10 bytes
.DEFINE working_stack_pointer_address $C000


.DEFINE magic_byte_value $69


RAM_SHARING_MAGIC_BYTES:
.DB "SRAM_CFG"


.IFDEF game_uses_save_ram
    NUMBER_OF_BANKS:
    .DB 4

    GAME_SRAM:
    .DB 0

    SAVE_STATE_RAM_BANK_SRAM:
    .DB 1

.ELSE
    NUMBER_OF_BANKS:
    .DB 2
.ENDIF

    SAVE_STATE_RAM_BANK_VRAM:
    .DB 2

    SAVE_STATE_RAM_BANK:
    .DB 3



SAVE_STATE_PATCH_MAGIC_BYTES:
.DB "SSPMB"