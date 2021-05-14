CC=clang
CFLAGS=-Ofast -g

all: arithmetic.s arithmetic

arithmetic.s: arithmetic.c
	$(CC) $(CFLAGS) -S -masm=intel -fverbose-asm $<

arithmetic: arithmetic.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f arithmetic arithmetic.s
