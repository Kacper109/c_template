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

# TODO: Recursive dependency
all: build debug 

build: $(BUILD_DIR)
	mkdir $(BUILD_DIR)

compile: $(objects)
	$(CC) $(objects) -o $(NAME_EXE)

debug: debug-build $(objects) compile

release: release-build $(objects) compile

run: $(NAME_EXE)
	./$(NAME_EXE)

clean: $(BUILD_DIR) $(NAME_EXE)
	rm -rf $(BUILD_DIR)
	rm $(NAME_EXE)

release-build %.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS_RELEASE) -c $< -o $(BUILD_DIR)/$@
	
debug-build %.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS_DEBUG) -c $< -o $(BUILD_DIR)/$@

.PHONY: all
