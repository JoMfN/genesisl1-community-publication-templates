PYTHON ?= python3

.PHONY: all clean assets build paper packages web audit smoke lint chemistry-assets

all:
	$(PYTHON) tools/build.py all

clean:
	$(PYTHON) tools/build.py clean

assets:
	$(PYTHON) tools/build.py assets

build:
	$(PYTHON) tools/build.py compile

paper:
	$(PYTHON) tools/build.py paper

packages:
	$(PYTHON) tools/build.py packages

web:
	$(PYTHON) tools/build.py all

audit:
	$(PYTHON) tools/privacy_audit.py web

smoke:
	$(PYTHON) tools/build.py smoke


lint:
	$(PYTHON) tools/manuscript_lint.py $(or $(FILE),templates/scientific-paper/template.tex)

# Optional and deliberately outside the default build.
# Requires Open Babel's `obabel` executable.
chemistry-assets:
	$(PYTHON) tools/render_smiles.py \
	  --input templates/scientific-paper/examples/chemistry/compounds.tsv \
	  --output templates/scientific-paper/examples/chemistry/generated
