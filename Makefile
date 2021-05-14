WPP := w++
SRCDIR := docs
HTMLDIR := html
MDDIR := md
SRCFILES := $(shell find $(SRCDIR) -name "*.wpp" -type f)
HTMLFILES := $(patsubst $(SRCDIR)/%.wpp,$(HTMLDIR)/%.html,$(SRCFILES))
MDFILES := $(patsubst $(SRCDIR)/%.wpp,$(MDDIR)/%.md,$(SRCFILES))
SEARCH_PATH := $(shell pwd)/backends/

.phony: clean

all: $(HTMLFILES) $(MDFILES) readme.md
	cp assets/* html/ -rf

clean:
	rm readme.md backends/backend.wpp $(HTMLFILES) $(MDFILES)

$(HTMLDIR):
	mkdir -p $@

$(MDDIR):
	mkdir -p $@

$(HTMLDIR)/%.html: $(SRCDIR)/%.wpp backends/html.wpp $(HTMLDIR)
	ln -Pf backends/html.wpp backends/backend.wpp
	$(WPP) -s $(SEARCH_PATH) $< > $@

$(MDDIR)/%.md: $(SRCDIR)/%.wpp backends/markdown.wpp $(MDDIR)
	ln -Pf backends/markdown.wpp backends/backend.wpp
	$(WPP) -s $(SEARCH_PATH) $< > $@

readme.md: readme.wpp
	$(WPP) -s $(SEARCH_PATH) $< > $@

