; we can't define symbols on the command lin so...
define DEBUG = 1

; we use this when targeting emulators
mif(isDefined(DEBUG)) {
org 0x0000

define SZ_PRG = 0x02
define SZ_CHR = 0x01
define MAPPER = 0x00
define MIRROR = 0x01
define SRAM   = 0x00

byte 'N', 'E', 'S', 0x1A
byte SZ_PRG
byte SZ_CHR
byte MIRROR | (SRAM << 1) | ((MAPPER & 0x0F) << 4)
byte MAPPER & 0B11110000
byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
}
