.PHONY: all xhello

all:
	cc -g -Wall -I/usr/include/freetype2 -lXft -o xecho xecho.c

xhello:
	cc -I/usr/include/freetype2 -lXft -o xhello xhello.c
