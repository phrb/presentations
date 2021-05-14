OUTPUT=mpi_pi_reduce
MCC=mpicc

.PHONY: all

all: $(OUTPUT)

$(OUTPUT): $(OUTPUT).c
	$(MCC) -o $(OUTPUT) $(OUTPUT).c

.PHONY: clean
clean:
	rm $(OUTPUT)
