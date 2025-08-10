C_VERSION = c23
CFLAGS := -I$(INCLUDE_DIR) -std=$(C_VERSION) -Wall -Werror -Wextra -Wpedantic -pedantic-errors 
CFLAGS_DEBUG = -g3 -fsanitize=address,leak,undefined
CFLAGS_RELEASE = -O3

BUILD_DIR = ./build
SRC_DIR = ./src
INCLUDE_DIR = ./include

NAME_EXE = example
SOURCES = $(wildcard $(SRC_DIR)/*.c)
OBJECTS = $(addprefix $(BUILD_DIR)/, $(notdir $(SOURCES:.c=.o)))
HEADERS = $(wildcard $(INCLUDE_DIR)/*.h)

all: debug 

test-debug: debug run clean
test-release: release run clean

run: $(NAME_EXE)
	./$(NAME_EXE)

clean:
	git clean -Xfd

update: clean
	git pull

# TODO: Fix debug 
debug: CFLAGS += $(CFLAGS_DEBUG)
debug: $(OBJECTS) $(NAME_EXE)

release: CFLAGS += $(CFLAGS_RELEASE)
release: $(OBJECTS) $(NAME_EXE)

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

$(NAME_EXE): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $(NAME_EXE)

$(OBJECTS): $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	$(CC) $(CFLAGS) -c -o $@ $<

.PHONY: all test-debug test-release clean update debug release
