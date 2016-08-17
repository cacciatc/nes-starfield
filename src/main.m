include "src/header.m"

org 0x8000

; vector.m needs these labels
extern reset
extern nmi

variable nmi_status = 0x01

; entry point
main:
    jsr reset
    
    game_loop:
        ; handle game processing

        ; now wait for nmi
        nmi_status = 0x00
        while(!equal) {        
            lda nmi_status
        }
        jmp @game_loop

reset:
    rts

; non-maskable interrupt
nmi:
    save_reg
    
    ; mark nmi as done
    nmi_status = 0x01

    restore_reg
    rti
