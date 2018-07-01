BDFDEST ?= /usr/share/fonts
PSFDEST ?= /usr/share/consolefonts

BDFS = $(wildcard leggie-*.bdf)
PSFUS = $(BDFS:.bdf=.psfu) leggie-egauni.psfu leggie-vgauni.psfu
PSFS = leggie-ega.psf leggie-vga.psf
GZS = $(PSFUS:.psfu=.psfu.gz) $(PSFS:.psf=.psf.gz)

install: installbdf installpsf
psf: $(PSFUS) $(PSFS)

.bdf.psfu:
	bdf2psf --fb $< psf/equiv \
	psf/cp437+psf/eu+psf/iso8859+psf/cp1252+psf/powerline+psf/useful \
	512 $@

EGAVGAPSFU = bdf2psf $< psf/equiv \
	psf/cp437+psf/eu+psf/iso8859+psf/cp1252+psf/powerline+psf/useful \
	512 $@
leggie-egauni.psfu: leggie-14v.bdf
	$(EGAVGAPSFU)
leggie-vgauni.psfu: leggie-16v.bdf
	$(EGAVGAPSFU)

EGAVGAPSF = bdf2psf $< psf/linux psf/cp437 256 $@
leggie-ega.psf: leggie-14v.bdf
	$(EGAVGAPSF)
leggie-vga.psf: leggie-16v.bdf
	$(EGAVGAPSF)

installbdf:
	mkdir -p $(BDFDEST)/leggie
	cp LICENCE README $(BDFDEST)/leggie
	cp $(BDFS) $(BDFDEST)/leggie
	cp fonts.dir $(BDFDEST)/leggie

installpsf: psf
	mkdir -p $(PSFDEST)
	cat README LICENCE > $(PSFDEST)/README.leggie
	gzip -1 $(PSFUS) $(PSFS)
	cp $(GZS) $(PSFDEST)

.PHONY: install installbdf installpsf psf
.SUFFIXES: .bdf .psfu
