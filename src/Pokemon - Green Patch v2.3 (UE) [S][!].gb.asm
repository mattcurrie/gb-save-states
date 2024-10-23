; md5 1e9baf36b209fd06854b8e5e064b00a8

; ROMBANKS 64
; ROM "Pokemon - Green Patch v2.3 (UE) [S][!].gb"


; config
DEF current_rom_bank EQU $ffb8
DEF game_uses_save_ram EQU 1
DEF current_sram_bank EQU $fffd
DEF uses_mbc5 EQU 1


; mbc 5 fix
SECTION "patch rom bank 0 req", ROMX[$6763], BANK[$0001] ; length: $1
    DB $01
ENDSECTION


; track current sram bank
SECTION "set sram bank", ROM0[$0001] ; length: $0007
set_sram_bank:
    ld [current_sram_bank], a
    ld [$4000], a
    ret
ENDSECTION

SECTION "call set sram bank 1", ROM0[$250d] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 2", ROM0[$169d] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 3", ROM0[$16eb] ; length: $3
    call set_sram_bank
ENDSECTION

SECTION "call set sram bank 4", ROMX[$60A8], BANK[$0001] ; length: $3
    call set_sram_bank
ENDSECTION

SECTION "call set sram bank 5", ROMX[$762D], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 6", ROMX[$769A], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 7", ROMX[$76C7], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 8", ROMX[$7ADB], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 9", ROMX[$7796], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 10", ROMX[$77EC], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 11", ROMX[$7819], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 12", ROMX[$791A], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 13", ROMX[$7A35], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 14", ROMX[$7A3D], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 15", ROMX[$7A94], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 16", ROMX[$7A9C], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 17", ROMX[$7B5C], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION
SECTION "call set sram bank 18", ROMX[$7B8F], BANK[$001c] ; length: $3
    call set_sram_bank
ENDSECTION

SECTION "call set sram bank 19", ROMX[$6CE1], BANK[$000f] ; length: $3
    call set_sram_bank
ENDSECTION


; joypad
DEF joypad EQU $fff8

SECTION "relocated read from joypad", ROM0[$00bf] ; length: $0040
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0195] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7D00], BANK[$0001] ; length: $0260
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

