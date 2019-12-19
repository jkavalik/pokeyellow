INCLUDE "charmap.asm"
INCLUDE "constants/text_constants.asm"

INCLUDE "macros.asm"
INCLUDE "hram.asm"


SECTION "Text 1", ROMX ; BANK $26

IF DEF(LOC_CS)
	INCLUDE "text_cs.asm"
ELSE
	INCLUDE "text_orig.asm"
ENDC
