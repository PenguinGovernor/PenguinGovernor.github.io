# Go Related Items
GO_FILES := $(shell find . -type f -name "*.go")
BIN_NAME := webgen
BIN_DIR := ./cmd/webgen

# Templates
TEMPLATES := templates/index.html templates/body.md

# Public
PUBLIC_DIR := public
PUBLIC_FILES := $(wildcard $(PUBLIC_DIR)/*)

# Output
OUTPUT_DIR := dist
OUTPUT_INDEX := $(OUTPUT_DIR)/index.html
OUTPUT_FILES := $(patsubst $(PUBLIC_DIR)/%, $(OUTPUT_DIR)/%, $(PUBLIC_FILES)) $(OUTPUT_INDEX)

$(OUTPUT_INDEX): $(BIN_NAME) $(OUTPUT_DIR) $(TEMPLATES) $(PUBLIC_FILES)
	./$(BIN_NAME) \
		-index $(word 1,$(TEMPLATES)) \
		-markdown $(word 2,$(TEMPLATES)) \
		> $@
	cp $(PUBLIC_FILES) $(OUTPUT_DIR)

$(BIN_NAME): $(GO_FILES)
	go build -o $(BIN_NAME) $(BIN_DIR)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

.PHONY: clean
clean:
	- go clean
	- rm $(OUTPUT_FILES)
	- rm $(BIN_NAME)
