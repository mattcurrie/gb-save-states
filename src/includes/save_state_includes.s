.INCLUDE "includes/defines.s"
.INCLUDE "includes/check_for_load_or_save.s"
.INCLUDE "includes/load_and_save.s"
.INCLUDE "includes/io_copy.s"
.IFNDEF is_cgb
.INCLUDE "includes/packbits_encode.s"
.INCLUDE "includes/packbits_decode.s"
.ENDIF