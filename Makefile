ASM_FLAGS = -c
ASM       = macross $(ASM_FLAGS)
LNK_FLAGS = -o bin/starfield.o
LNK       = slinky $(LNK_FLAGS)

debug: bin/starfield.nes

bin/starfield.nes: bin/starfield.o
	ruby utils/to_rom.rb

bin/starfield.o: src/main.o src/ines.o src/vectors.o
	$(LNK) src/ines.o src/main.o src/vectors.o

src/main.o: src/main.m
	$(ASM) $< -o $@

src/ines.o: src/ines.m
	$(ASM) $< -o $@

src/vectors.o: src/vectors.m
	$(ASM) $< -o $@

.PHONY clean:
	rm src/*.o
	rm bin/starfield.nes
	rm bin/starfield.o
