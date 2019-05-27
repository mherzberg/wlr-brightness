INSTALL_PATH?=/usr/local
WAYLAND_SCANNER=$(shell pkg-config --variable=wayland_scanner wayland-scanner)
LIBS=\
	$(shell pkg-config --cflags --libs wlroots) \
	$(shell pkg-config --cflags --libs wayland-client) \
	$(shell pkg-config --cflags --libs xkbcommon) \
	$(shell pkg-config --cflags --libs gio-2.0 gio-unix-2.0 glib-2.0) \
	-lm

out/wlr-brightness: out \
	src/wlr-brightness.c \
	gen/wlr-gamma-control-unstable-v1-client-protocol.h \
	gen/wlr-gamma-control-unstable-v1-client-protocol.c \
	gen/wlrbrightnessbus.h \
	gen/wlrbrightnessbus.c
	$(CC) $(CFLAGS) \
		-I. -Werror -DWLR_USE_UNSTABLE \
		$(LIBS) \
		-o $@ \
		src/wlr-brightness.c \
		gen/wlr-gamma-control-unstable-v1-client-protocol.c \
	  gen/wlrbrightnessbus.c

gen/wlr-gamma-control-unstable-v1-client-protocol.h: gen
	$(WAYLAND_SCANNER) client-header \
		vendor/wlr-protocols/unstable/wlr-gamma-control-unstable-v1.xml $@

gen/wlr-gamma-control-unstable-v1-client-protocol.c: gen 
	$(WAYLAND_SCANNER) private-code \
		vendor/wlr-protocols/unstable/wlr-gamma-control-unstable-v1.xml $@

gen/wlrbrightnessbus.c gen/wlrbrightnessbus.h: gen
	gdbus-codegen --output-directory gen --generate-c-code wlrbrightnessbus \
		--c-namespace WlrBrightnessBus --interface-prefix de.mherzberg. \
		res/de.mherzberg.wlrbrightness.xml

gen:
	mkdir -p gen

out:
	mkdir -p out

install:
	install -Dm755 out/wlr-brightness $(INSTALL_PATH)/bin/wlr-brightness

clean:
	rm -rf out gen

.PHONY: clean
