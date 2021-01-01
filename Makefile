# Go Related Items
GO_FILES := $(shell find . -type f -name "*.go")
BIN_NAME := webgen
BIN_DIR := ./cmd/webgen

# Templates
TEMPLATES := templates/index.html templates/body.md

# Public
PUBLIC_DIR := public
PUBLIC_FILES := $(wildcard $(PUBLIC_DIR)/*)

# CNAME contents
CNAME := "www.jorgehenriquez.dev"

# Output
OUTPUT_DIR := dist
OUTPUT_INDEX := $(OUTPUT_DIR)/index.html
OUTPUT_CNAME := $(OUTPUT_DIR)/CNAME
OUTPUT_FILES := $(patsubst $(PUBLIC_DIR)/%, $(OUTPUT_DIR)/%, $(PUBLIC_FILES)) $(OUTPUT_INDEX) $(OUTPUT_DIR)/CNAME


all: website
website: $(OUTPUT_INDEX) $(OUTPUT_CNAME)

# This creates the website
$(OUTPUT_INDEX): $(BIN_NAME) $(OUTPUT_DIR) $(TEMPLATES) $(PUBLIC_FILES)
	./$(BIN_NAME) \
		-index $(word 1,$(TEMPLATES)) \
		-markdown $(word 2,$(TEMPLATES)) \
		> $@
	cp $(PUBLIC_FILES) $(OUTPUT_DIR)

$(OUTPUT_CNAME): $(OUTPUT_DIR)
	echo $(CNAME) > $(OUTPUT_CNAME)

# This builds the go program.
$(BIN_NAME): $(GO_FILES)
	go build -o $(BIN_NAME) $(BIN_DIR)

# This makes the output directory.
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# This cleans the project.
.PHONY: clean
clean:
	- go clean
	- rm $(OUTPUT_FILES)
	- rm $(BIN_NAME)

.PHONY: publish
publish:
	git subtree push --prefix $(OUTPUT_DIR) origin gh-pages
