default: build

#Dir Magic
DIR=$(realpath .)

DIRNAME=$(subst $(dir $(DIR)),,$(DIR))

ifeq ($(DIRNAME),Documentation)
	BASEDIR:=$(realpath $(DIR)/..)
else
	BASEDIR:=$(DIR)
endif

DIR=$(BASEDIR)/Documentation

# Make Doc
build:
	@pdflatex -file-line-error --interaction=nonstopmode -shell-escape *.tex | grep ".*:[0-9]*:.*" && echo Error || echo Success
	@xelatex -file-line-error --interaction=nonstopmode -shell-escape *.tex | grep ".*:[0-9]*:.*" && echo Error || echo Success
	@# pdflatex *.tex
	@# biber mydocument
	@# pdflatex mydocument.tex
	@# pdflatex mydocument.tex
silent:
	@echo pdflatex *.tex
	@pdflatex *.tex > /dev/null 2>&1

open:
	@#Escape Makefile $ with $$
	@for f in *.tex; do (which zathura >/dev/null 2>&1 && zathura -x s $${f%.tex}.pdf || xdg-open $${f%.tex}.pdf &); done &

show: open

update: build open


# Release Übung
prepend_title:
	@for f in *.tex; do [ -f Title_Page.pdf ] && [ -f $${f%.tex}.pdf ] && qpdf --empty --pages Title_Page.pdf $${f%.tex}.pdf -- out.pdf && mv out.pdf $${f%.tex}.pdf || echo Prepend Failed; done

zip:
	@for f in *.tex; do [ -f $${f%.tex}.pdf ] && mkdir -p $${f%.tex} Upload && cp -r ../Programs/{*.pas,Units} $${f%.tex} && zip -r $${f%.tex}.zip $${f%.tex} >/dev/null >&1 && cp $${f%.tex}.zip $${f%.tex}.pdf Upload; done

abgabe: build prepend_title zip clean

.PHONY: clean abgabe zip prepend_title update show open silent build default

# Clean
clean:
	-rm -f *.aux
	-rm -f *.log
	-rm -f *.lof
	-rm -f *.bbl
	-rm -f *.blg
	-rm -f *.lot
	-rm -f *.out
	-rm -f *.toc
	-rm -f *.bcf
	-rm -f *.run.xml
	-rm -f *.blx.bib
	-rm -f *.zip
	@echo
	@$(MAKE) -C $(BASEDIR)/Programs clean | tail -n +2 | head -n -1
