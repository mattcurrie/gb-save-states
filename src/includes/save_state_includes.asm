INCLUDE "includes/hardware.inc"
INCLUDE "includes/defines.asm"
PUSHS ; header gets it's own section
INCLUDE "includes/header.asm"
POPS
INCLUDE "includes/check_for_load_or_save.asm"
INCLUDE "includes/load_and_save.asm"
INCLUDE "includes/io_copy.asm"
IF !DEF(is_cgb)
INCLUDE "includes/packbits_encode.asm"
INCLUDE "includes/packbits_decode.asm"
ENDC
