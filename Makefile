BDFDEST ?= /usr/share/fonts
PSFDEST ?= /usr/share/consolefonts

BDFS = $(wildcard leggie-*.bdf)
PSFUS = $(BDFS:.bdf=.psfu)
PSFUGZS = $(PSFUS:.psfu=.psfu.gz)

.bdf.psfu:
	bdf2psf --fb $< psf/equiv \
	psf/ascii.set+psf/linux.set+psf/useful.set+psf/powerline.set+psf/intl.set \
	512 $@

installbdf:
	mkdir -p $(BDFDEST)/leggie
	cp LICENSE README $(BDFDEST)/leggie
	cp $(BDFS) $(BDFDEST)/leggie
	mkfontdir $(BDFDEST)/leggie

installpsf: psf
	mkdir -p $(PSFDEST)
	cat README LICENSE > $(PSFDEST)/README.leggie
	gzip -1 $(PSFUS)
	cp $(PSFUGZS) $(PSFDEST)

install: installbdf installpsf

psf: $(PSFUS)
	
.PHONY: install installbdf installpsf psf
.SUFFIXES: .bdf .psfu
