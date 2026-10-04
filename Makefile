TALKS := $(sort $(patsubst %/,%,$(dir $(wildcard */slides.typ */default.nix))))

all: $(TALKS)

$(TALKS):
	nix build .#$@ -o $@.pdf

.PHONY: all $(TALKS)
