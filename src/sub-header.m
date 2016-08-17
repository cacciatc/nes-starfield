; defines

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
