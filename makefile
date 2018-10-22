export PREFIX?=/usr
export DOCDIR?=$(DESTDIR)$(PREFIX)/share/man/man1

.PHONY: all clean
CFLAGS?=-g -Wall 
PKG_CONFIG?=pkg-config
CFLAGS+=$(shell $(PKG_CONFIG) --cflags freetype2)
LDLIBS+=$(shell $(PKG_CONFIG) --libs freetype2) -lXft -lm -lXext -lX11

all: xecho xecho.1.gz

install:
	install -m 0755 xecho "$(DESTDIR)$(PREFIX)/bin"
	install -g 0 -o 0 -m 0644 xecho.1.gz "$(DOCDIR)"

xecho.1.gz:
	gzip -c < xecho.1 > $@

clean:
	$(RM) xecho xecho.1.gz

displaytest:
	valgrind -v --leak-check=full --track-origins=yes --show-reachable=yes ./xecho -vv qmt

updatetest:
	valgrind --track-origins=yes --leak-check=full ./xecho -stdin -padding 10 -size 20 -align nw
