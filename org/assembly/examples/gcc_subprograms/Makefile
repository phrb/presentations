CC=/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/cc1
CFLAGS=-quiet -I/usr/include/
ASM=as
ASMFLAGS=--64
LD=ld
LDFLAGS= -m elf_x86_64 -dynamic-linker /usr/lib/ld-linux-x86-64.so.2 -pie \
/usr/lib/Scrt1.o \
/usr/lib/crti.o \
/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/crtbeginS.o \
-L/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0 \
-lc -lgcc \
/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/crtendS.o \
/usr/lib/crtn.o

bin: a.o b.o
	$(LD) $(LDFLAGS) $^ -o $@

a.s: a.c
	$(CC) $(CFLAGS) $< -o $@

b.s: b.c
	$(CC) $(CFLAGS) $< -o $@

%.o: %.s
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f *.s *.o bin
