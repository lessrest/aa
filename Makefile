I7 ?= /home/mbrock/i7/result/bin
SOURCE ?= aa.ni
WWW_ROOT ?= /var/www/aa
BUILD_DIR ?= build
WEB_BUILD := $(BUILD_DIR)/www

.PHONY: check glulx www clean-www

check:
	$(I7)/i7-check $(SOURCE)

glulx:
	$(I7)/i7-build --glulx $(SOURCE) active-approach.ulx

www:
	rm -rf $(WEB_BUILD)
	$(I7)/i7-release-web --glulx --force $(SOURCE) $(WEB_BUILD)
	mkdir -p $(WWW_ROOT)
	rsync -a --delete --chmod=D755,F644 $(WEB_BUILD)/ $(WWW_ROOT)/

clean-www:
	rm -rf $(WEB_BUILD)
