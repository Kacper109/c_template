CC = /usr/bin/clang
LD = /usr/bin/mold

CFLAGS = -std=c23 -Wall -Werror -Wextra -Wpedantic -pedantic-errors -fuse-ld=$(LD)
CFLAGS_DEBUG = $(CFLAGS) -g3
CFLAGS_RELEASE = $(CFLAGS) -O3

objects = main.o
objects-debug = main.debug.o

all: $(objects-debug)

$(objets-debug): %.debug.o: src/%.c
	$(CC) $(CFLAGS_DEBUG) -c $< -o $@

$(objects): %.o: src/%.c
	$(CC) $(CFLAGS_RELEASE) -c $< -o $@
