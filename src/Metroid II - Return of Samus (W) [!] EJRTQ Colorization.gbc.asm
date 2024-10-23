; md5 f005cbcb60f4d9f3e4f6190e809cff1d

; ROMBANKS 64
; ROM "Metroid II - Return of Samus (W) [!] EJRTQ Colorization.gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $d04e
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ff80
DEF joypad_2 EQU $ff81

SECTION "relocated read from joypad", ROM0[$007c] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$22b7] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7B98], BANK[$0001] ; length: $0295
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; mbc1->mbc5 patch
SECTION "mbc1 to mbc5 patch", ROM0[$00c0] ; length: 24
set_rom_bank_bit_5:
    ld a, [current_rom_bank]
    or $20
    ; ld [current_rom_bank], a
    ld [$2100], a
    ret

reset_rom_bank_bit_5:
    ld a, [current_rom_bank]
    ld [$2100], a
    ret
ENDSECTION

SECTION "set bit 5", ROM0[$3f83] ; length: 5
    call set_rom_bank_bit_5
    nop
    nop
ENDSECTION

SECTION "reset bit 5", ROM0[$3f9a] ; length: 4
    call reset_rom_bank_bit_5
    nop
ENDSECTION


; Generated with patch-builder.py
