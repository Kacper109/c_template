.POSIX:

CC = /usr/bin/clang
LD = /usr/bin/mold

CFLAGS = -std=c23 -Wall -Werror -Wextra -Wpedantic -pedantic-errors 
CFLAGS_DEBUG = $(CFLAGS) -g3
CFLAGS_RELEASE = $(CFLAGS) -O3

BUILD_DIR = ./build
SRC_DIR = ./src

NAME_EXE = example

objects = main.o
objects-debug = main.debug.o

# TODO: Recursive dependency
all: debug 

build: $(BUILD_DIR)
	mkdir $(BUILD_DIR)

debug: build $(objects-debug)
	$(CC) $(BUILD_DIR)/* -o $(NAME_EXE)

run: $(NAME_EXE)
	./$(NAME_EXE)

clean: $(BUILD_DIR) $(NAME_EXE)
	rm -rf $(BUILD_DIR)
	rm $(NAME_EXE)

%.debug.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS_DEBUG) -c $< -o $(BUILD_DIR)/$@

%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS_RELEASE) -c $< -o $(BUILD_DIR)/$@

.PHONY: all run clean
