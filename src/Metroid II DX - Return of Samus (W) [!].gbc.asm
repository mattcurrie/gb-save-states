; md5 57032a17c7e6aa00eb8e064a87279898

; ROMBANKS 32
; ROM "Metroid II DX - Return of Samus (W) [!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $d04e
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ff80
DEF joypad_2 EQU $ff81

SECTION "relocated read from joypad", ROM0[$009e] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$22b7] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7B88], BANK[$0001] ; length: $0295
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
