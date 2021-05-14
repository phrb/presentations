TEMP_DIR = .temptex

SRC = presentation.tex
PDF = presentation.pdf
DTX = $(wildcard *.dtx)
STY = $(patsubst %.dtx,%.sty,$(wildcard beamer*.dtx pgfplotsthemetol.dtx))

TEXC := latexmk -xelatex -output-directory=$(TEMP_DIR)

.PHONY: sty slides

all: sty slides

$(STY): $(DTX) $(INS)
	@latex $(INS)

$(PDF): $(STY) $(SRC)
	$(TEXC) $(SRC)
	@cp $(TEMP_DIR)/$(PDF) .

sty: $(STY)

slides: $(PDF)

clean:
	@rm -rf "$(TEMP_DIR)"
