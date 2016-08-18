; defines

define OAM        = 0x0200

; PPU registers
define PPU_CTRL   = 0x2000
define PPU_MASK   = 0x2001
define PPU_STATUS = 0x2002
define OAM_ADDR   = 0x2003
define OAM_DATA   = 0x2004
define PPU_SCROLL = 0x2005
define PPU_ADDR   = 0x2006
define PPU_DATA   = 0x2007
define OAM_DMA    = 0x2008

define APU_FRAME  = 0x4017

define DMC_FLAGS  = 0x4010

; zero-page labels

; macros
macro save_reg {
    pha
    txa
    pha
    tya
    pha
}

macro restore_reg {
    pla
    tay
    pla
    tax
    pla
}

; functions
