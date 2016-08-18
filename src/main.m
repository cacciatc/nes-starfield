include "src/header.m"

; place in first bank
org 0x8000

; vector.m needs these labels
extern reset
extern nmi

variable nmi_status = 0x01

; entry point
main:
    jsr reset
    jsr clear_memory
   
    ; wait for first vblank
    jsr wait_for_vblank

    ; initialize engine

    ; wait for second vblank
    jsr wait_for_vblank

    ; enable NMI
    lda 0xF0
    sta PPU_CTRL
    
    game_loop:
        ; handle game processing
        ; read input
        ; update state

        ; now wait for nmi
        nmi_status = 0x00
        while(!equal) {        
            lda nmi_status
        }
        jmp @game_loop

wait_for_vblank:
    poll_vblank:
        bit PPU_STATUS
        bpl poll_vblank
    
    rts

clear_memory:
    ldx 0x00

    mvariable i
    mfor(i = 0, i != 0, i++) {
        sta 0x0000, x
        sta 0x0100, x
        sta 0x0300, x
        sta 0x0400, x
        sta 0x0500, x
        sta 0x0600, x
        sta 0x0700, x

        ; clear OAM buffer
        lda 0xFE
        sta OAM, x
    }
    rts

reset:
    ; disable IRQs
    sei
    
    ; disable decimal mode
    cld
    
    ; disable APU frame IRQ
    ldx 0x40
    stx APU_FRAME
    
    ; setup stack
    ldx 0xFF
    txs
    inx
    
    ; disable NMI
    stx PPU_CTRL
    
    ; disable rendering
    stx PPU_MASK

    ; disable DMC IRQs
    stx DMC_FLAGS 
    
    rts

; non-maskable interrupt
nmi:
    save_reg
    
    ; mark nmi as done
    nmi_status = 0x01

    restore_reg
    rti
