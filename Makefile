BDFDEST ?= /usr/share/fonts
PSFDEST ?= /usr/share/consolefonts

BDFS = $(wildcard leggie-*.bdf)
PSFUS = $(BDFS:.bdf=.psfu)
GZS = $(PSFUS:.psfu=.psfu.gz)

install: installbdf installpsf
psf: $(PSFUS)

.bdf.psfu:
	bdf2psf --fb $< psf/equiv \
	psf/cp437+psf/eu+psf/iso8859+psf/cp1252+psf/powerline+psf/useful \
	512 $@

installbdf:
	mkdir -p $(BDFDEST)/leggie
	cp LICENCE README $(BDFDEST)/leggie
	cp $(BDFS) $(BDFDEST)/leggie
	cp fonts.dir $(BDFDEST)/leggie

installpsf: $(PSFUS)
	mkdir -p $(PSFDEST)
	cat README LICENCE > $(PSFDEST)/README.leggie
	gzip -1 $(PSFUS)
	cp $(GZS) $(PSFDEST)

.PHONY: install installbdf installpsf psf
.SUFFIXES: .bdf .psfu
