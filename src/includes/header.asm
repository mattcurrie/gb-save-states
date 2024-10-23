; header

SECTION "cartridge type", ROM0[$0147]
IF DEF(uses_mbc5)
    DB CART_ROM_MBC5_RAM_BAT
ELSE
    DB CART_ROM_MBC1_RAM_BAT
ENDC
ENDSECTION

SECTION "ram size", ROM0[$0149]
    DB RAMSIZE
ENDSECTION

SECTION "checksums", ROM0[$014d]
    DB $00, $00, $00    ; zero out to stop warning from rgbfix
ENDSECTION