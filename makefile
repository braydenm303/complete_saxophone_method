SHELL=/bin/sh
FILE=saxophone
OUTDIR=out
WEBDIR=htmlout
VIEWER=xpdf
BROWSER=firefox
LILYBOOK_PDF=lilypond-book --output=$(OUTDIR) --pdf $(FILE).lytex
LILYBOOK_HTML=lilypond-book --output=$(WEBDIR) $(FILE).lytex
PDF=cd $(OUTDIR) && pdflatex $(FILE)
HTML=cd $(WEBDIR) && latex2html $(FILE)
INDEX=cd $(OUTDIR) && makeindex $(FILE)
PREVIEW=$(VIEWER) $(OUTDIR)/$(FILE).pdf &

all: pdf web keep

pdf: $(FILE).lytex
	$(LILYBOOK_PDF)
	$(PDF)
	$(INDEX)
	$(PDF)
	$(PREVIEW)

web:
	$(LILYBOOK_HTML)
	$(HTML)
	cp -R $(WEBDIR)/$(FILE)/ ./
	$(BROWSER) $(FILE)/$(FILE).html &

keep: pdf
	cp $(OUTDIR)/$(FILE).pdf $(FILE).pdf

clean:
	rm -rf $(OUTDIR)

web-clean:
	rm -rf $(WEBDIR)

archive:
	tar -cvvf myproject.tar \
	--exclude=out/* \
	--exclude=htmlout/* \
	--exclude=myproject/* \
	--exclude=*midi \
	--exclude=*pdf \
	--exclude=*~ \
	../MyProject/*
