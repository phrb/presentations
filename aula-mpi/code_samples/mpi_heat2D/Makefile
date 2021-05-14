OUTPUT=mpi_heat2D
FILES=draw_heat.c
MCC=mpicc
MCC_OPT=-lX11

.PHONY: all

all: $(OUTPUT)

$(OUTPUT): $(OUTPUT).c $(FILES)
	$(MCC) -o $(OUTPUT) $(OUTPUT).c $(FILES) $(MCC_OPT)

.PHONY: clean
clean:
	rm $(OUTPUT) *.dat
