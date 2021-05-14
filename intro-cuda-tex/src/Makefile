TEMP_DIR = .temptex

PT_SRC = intro-cuda-pt.tex
PT_PDF = intro-cuda-pt.pdf

EN_SRC = intro-cuda-en.tex
EN_PDF = intro-cuda-en.pdf

DTX = $(wildcard *.dtx)
STY = $(patsubst %.dtx,%.sty,$(wildcard beamer*.dtx pgfplotsthemetol.dtx))

TEXC := latexmk -xelatex -output-directory=$(TEMP_DIR)

.PHONY: sty slides-en slides-pt

all: sty slides-en slides-pt

$(STY): $(DTX) $(INS)
	@latex $(INS)

$(EN_PDF): $(STY) $(EN_SRC)
	$(TEXC) $(EN_SRC)
	@cp $(TEMP_DIR)/$(EN_PDF) .

$(PT_PDF): $(STY) $(PT_SRC)
	$(TEXC) $(PT_SRC)
	@cp $(TEMP_DIR)/$(PT_PDF) .

sty: $(STY)

slides-en: $(EN_PDF)

slides-pt: $(PT_PDF)

clean:
	@rm -rf "$(TEMP_DIR)"
