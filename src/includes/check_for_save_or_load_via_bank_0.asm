CHECK_FOR_SAVE_OR_LOAD_GAME_VIA_BANK_0:


    ld a,:CHECK_FOR_SAVE_OR_LOAD_GAME
    ld ($2000),a
    call CHECK_FOR_SAVE_OR_LOAD_GAME

    push af
    ld a,:joypad_check
    ld ($2000),a
    pop af

    ret
