.POSIX:

CC = /usr/bin/clang
LD = /usr/bin/mold

CFLAGS = -std=c23 -Wall -Werror -Wextra -Wpedantic -pedantic-errors 
CFLAGS_DEBUG = -g3
CFLAGS_RELEASE = -O3

BUILD_DIR = ./build
SRC_DIR = ./src

NAME_EXE = example
OBJECTS = main.o

all: debug 

test-debug: debug $(NAME_EXE)
	./$(NAME_EXE)

test-release: release $(NAME_EXE)
	./$(NAME_EXE)

debug: CFLAGS += $(CFLAGS_DEBUG)
debug: $(OBJECTS)

release: CFLAGS += $(CFLAGS_RELEASE)
release: $(OBJECTS)

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

$(NAME_EXE): $(OBJECTS)
	$(CC) $(BUILD_DIR)/* -o $(NAME_EXE)

clean:
	git clean -Xfd

$(OBJECTS): $(BUILD_DIR)

%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $(BUILD_DIR)/$@

.PHONY: all
