OUTPUT=hello_nonblocking
MCC=mpicc

.PHONY: all

all: $(OUTPUT)

$(OUTPUT): $(OUTPUT).c
	$(MCC) -o $(OUTPUT) $(OUTPUT).c

.PHONY: clean
clean:
	rm $(OUTPUT)
