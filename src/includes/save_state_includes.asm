.INCLUDE "includes/defines.asm"
.INCLUDE "includes/check_for_load_or_save.asm"
.INCLUDE "includes/load_and_save.asm"
.INCLUDE "includes/io_copy.asm"
.IFNDEF is_cgb
.INCLUDE "includes/packbits_encode.asm"
.INCLUDE "includes/packbits_decode.asm"
.ENDIF