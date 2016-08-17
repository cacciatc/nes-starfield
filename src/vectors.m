extern nmi
extern reset

org 0xFFFA

word nmi
word reset
word 0x00
