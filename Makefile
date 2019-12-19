PYTHON := python
pcm      := $(PYTHON) tools/pokemontools/pcm.py pcm

roms := pokeyellow.gbc pokeyellow_cs.gbc
rom_orig := pokeyellow.gbc
rom_cs := pokeyellow.gbc pokeyellow_cs.gbc

objs_common := audio.o wram.o
objs_orig := main.o text.o
objs_cs := main_cs.o text_cs.o

### Build tools

MD5 := md5sum -c

RGBDS ?=
RGBASM  ?= $(RGBDS)rgbasm
RGBFIX  ?= $(RGBDS)rgbfix
RGBGFX  ?= $(RGBDS)rgbgfx
RGBLINK ?= $(RGBDS)rgblink

### Build targets

.SUFFIXES:
.SECONDEXPANSION:
.PRECIOUS:
.SECONDARY:
.PHONY: all clean yellow tidy compare tools

all: $(roms)
yellow: pokeyellow.gbc
cs: pokeyellow_cs.gbc

# For contributors to make sure a change didn't affect the contents of the rom.
compare: $(roms)
	@$(MD5) roms.md5

clean:
	rm -f $(roms) $(objs_common) $(objs_orig) $(objs_cs) $(roms:.gbc=.sym)
	find . \( -iname '*.1bpp' -o -iname '*.2bpp' -o -iname '*.pic' -o -iname '*.pcm' \) -exec rm {} +
	$(MAKE) clean -C tools/
	

tidy:
	rm -f $(roms) $(objs_common) $(objs_orig) $(objs_cs) $(roms:.gbc=.sym)
	$(MAKE) clean -C tools/

tools:
	$(MAKE) -C tools/
	
# Build tools when building the rom.
# This has to happen before the rules are processed, since that's when scan_includes is run.
ifeq (,$(filter clean tools,$(MAKECMDGOALS)))
$(info $(shell $(MAKE) -C tools))
endif
	
%.asm: ;

%.o: dep = $(shell tools/scan_includes $(@D)/$*.asm)
$(objs_common): %.o: %.asm $$(dep)
	$(RGBASM) -h -o $@ $*.asm
$(objs_orig): %.o: %.asm $$(dep)
	$(RGBASM) -h -o $@ $*.asm

%_cs.o: dep = $(shell tools/scan_includes $(@D)/$*.asm)
$(objs_cs): %_cs.o: %.asm $$(dep)
	$(RGBASM) -D LOC_CS -h -o $@ $*.asm

opts = -cjsv -k 01 -l 0x33 -m 0x1b -p 0 -r 03 -t "POKEMON YELLOW"
opts_cs = -cjsv -k 01 -l 0x33 -m 0x1b -p 0 -r 03 -t "PKMN YELLOW CS"

pokeyellow.gbc: $(objs_orig) $(objs_common)
		$(RGBLINK) -n pokeyellow.sym -l pokeyellow.link -o $@ $^
		$(RGBFIX) $(opts) $@
		sort $(rom_orig:.gbc=.sym) -o $(rom_orig:.gbc=.sym)

pokeyellow_cs.gbc: $(objs_cs) $(objs_common)
		$(RGBLINK) -n pokeyellow_cs.sym -l pokeyellow.link -o $@ $^
		$(RGBFIX) $(opts_cs) $@
		sort $(rom_cs:.gbc=.sym) -o $(rom_cs:.gbc=.sym)

### Misc file-specific graphics rules

gfx/game_boy.2bpp: tools/gfx += --remove-duplicates
gfx/theend.2bpp: tools/gfx += --interleave --png=$<
gfx/tilesets/%.2bpp: tools/gfx += --trim-whitespace
gfx/pokemon_yellow.2bpp: tools/gfx += --trim-whitespace
gfx/surfing_pikachu_1c.2bpp: tools/gfx += --trim-whitespace
gfx/surfing_pikachu_3.2bpp: tools/gfx += --trim-whitespace
gfx/surfing_pikachu_1.2bpp: tools/gfx += --trim-whitespace
### Catch-all graphics rules

%.png:  ;

%.2bpp: %.png
	$(RGBGFX) $(rgbgfx) -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -o $@ $@)

%.1bpp: %.png
	$(RGBGFX) -d1 $(rgbgfx) -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -d1 -o $@ $@)

%.pic:  %.2bpp
	tools/pkmncompress $< $@
	

%.wav: ;
%.pcm: %.wav   ; @$(pcm)  $<
