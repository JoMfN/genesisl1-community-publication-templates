TEMPLATES := scientific-paper community-letter scientific-review scientific-letter protocol-method manual

.PHONY: all clean $(TEMPLATES)

all: $(TEMPLATES)

$(TEMPLATES):
	cd templates/$@ && pdflatex -interaction=nonstopmode -halt-on-error template.tex
	cd templates/$@ && pdflatex -interaction=nonstopmode -halt-on-error template.tex

clean:
	@for template in $(TEMPLATES); do \
		cd templates/$$template && rm -f *.aux *.log *.out *.toc *.bbl *.blg *.fls *.fdb_latexmk; \
		cd ../..; \
	done
