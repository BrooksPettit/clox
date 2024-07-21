TARGET_EXEC := main

BUILD_DIR := ./build
SRC_DIRS := ./src
TEST_DIR := ./tests

SRCS := $(shell find $(SRC_DIR) -name '*.c')
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)
TESTS := $(shell find $(TEST_DIR) -name '*.clox')
INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))
CPPFLAGS := $(INC_FLAGS) -MMD -MP
CFLAGS := -Wall -Wextra -ggdb -Wunreachable-code

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

.PHONY: run
run: $(BUILD_DIR)/$(TARGET_EXEC)
	$(BUILD_DIR)/$(TARGET_EXEC)

.PHONY: test
test: $(TESTS)
	for t in $^; do $(BUILD_DIR)/$(TARGET_EXEC) $$t; done

.PHONY: clean
clean:
	rm -r $(BUILD_DIR)

-include $(DEPS)

tags: $(SRCS)
	ctags -R --langmap=C:.c.h --fields=+l $(SRC_DIRS)
