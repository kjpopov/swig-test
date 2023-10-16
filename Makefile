# Makefile

# Set the output binary name
BINARY_NAME := swig-test

# Set the directories
SRC_DIR := .
SWIG_DIR := example

# Set the source files
SRCS := $(wildcard $(SRC_DIR)/*.go)
SWIG_SRCS := $(wildcard $(SWIG_DIR)/*.i)

# Set the SWIG generated wrapper file
SWIG_WRAPPER := $(SWIG_DIR)/example_wrap.cxx

# Set the SWIG generated Go file
SWIG_GO_FILE := $(SWIG_DIR)/example.go

.PHONY: gen

gen:
	swig -go -c++ $(SWIG_SRCS)

build:
	go build

all: gen build

clean:
	rm -f $(BINARY_NAME)
	rm -f $(SWIG_WRAPPER)
	rm -f $(SWIG_GO_FILE)
