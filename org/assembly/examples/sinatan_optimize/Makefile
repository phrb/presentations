CC=gcc
CFLAGS=-Ofast -g

all: sinatan.s sinatan

sinatan.s: sinatan.c
	$(CC) $(CFLAGS) -S -masm=intel -fverbose-asm $<

sinatan: sinatan.c
	$(CC) $(CFLAGS) -o $@ $< -fdump-tree-gimple -fdump-tree-optimized

clean:
	rm -f sinatan.s sinatan.c.* sinatan
