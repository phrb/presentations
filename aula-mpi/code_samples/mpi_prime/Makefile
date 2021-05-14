OUTPUT=mpi_prime
MCC=mpicc
MCC_OPT=-lm

.PHONY: all

all: $(OUTPUT)

$(OUTPUT): $(OUTPUT).c
	$(MCC) -o $(OUTPUT) $(OUTPUT).c $(MCC_OPT)

.PHONY: clean
clean:
	rm $(OUTPUT)
