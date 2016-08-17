ASM_FLAGS = -c
ASM       = macross $(ASM_FLAGS)
LNK_FLAGS = -o bin/starfield.nes
LNK       = slinky $(LNK_FLAGS)

debug: src/main.o src/ines.o src/vectors.o
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