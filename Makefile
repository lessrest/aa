NIX ?= nix
I7_FLAKE ?= ../../tools/inform7-nix
SOURCE ?= aa.ni
WWW_ROOT ?= /var/www/aa
BUILD_DIR ?= build
WEB_BUILD := $(BUILD_DIR)/www

I7_CHECK := $(NIX) run $(I7_FLAKE)\#i7-check --
I7_BUILD := $(NIX) run $(I7_FLAKE)\#i7-build --
I7_RELEASE_WEB := $(NIX) run $(I7_FLAKE)\#i7-release-web --

.PHONY: check glulx www clean-www

check:
	$(I7_CHECK) $(SOURCE)

glulx:
	$(I7_BUILD) --glulx $(SOURCE) active-approach.ulx

www:
	rm -rf $(WEB_BUILD)
	$(I7_RELEASE_WEB) --glulx --force $(SOURCE) $(WEB_BUILD)
	mkdir -p $(WWW_ROOT)
	rsync -a --delete --chmod=D755,F644 $(WEB_BUILD)/ $(WWW_ROOT)/

clean-www:
	rm -rf $(WEB_BUILD)
