OUTPUT=hello

CC=gcc
CC_OPT=-std=c11

CC_PTH=-pthread

.PHONY: all
all: $(OUTPUT)

$(OUTPUT): $(OUTPUT).c
	$(CC) -o $(OUTPUT) $(CC_OPT) $(CC_PTH) $(OUTPUT).c

.PHONY: clean
clean:
	rm $(OUTPUT)
