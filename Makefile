WPP := w++
SRCDIR := docs
HTMLDIR := html
MDDIR := md
SRCFILES := $(shell find $(SRCDIR) -name "*.wpp" -type f)
HTMLFILES := $(patsubst $(SRCDIR)/%.wpp,$(HTMLDIR)/%.html,$(SRCFILES))
MDFILES := $(patsubst $(SRCDIR)/%.wpp,$(MDDIR)/%.md,$(SRCFILES))
SEARCH_PATH := $(shell pwd)/backends/

.phony: clean

all: $(HTMLFILES) $(MDFILES)

clean:
	rm backends/backend.wpp $(HTMLFILES) $(MDFILES)

$(HTMLDIR):
	mkdir -p $@

$(MDDIR):
	mkdir -p $@

$(HTMLDIR)/%.html: $(SRCDIR)/%.wpp $(HTMLDIR)
	ln -Pf backends/html.wpp backends/backend.wpp
	$(WPP) -s $(SEARCH_PATH) -o $@ $<

$(MDDIR)/%.md: $(SRCDIR)/%.wpp $(MDDIR)
	ln -Pf backends/markdown.wpp backends/backend.wpp
	$(WPP) -s $(SEARCH_PATH) -o $@ $<

