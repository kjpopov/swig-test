# Makefile

# Set the output binary name
BINARY_NAME := main

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

lib:
	g++ -c -fPIC -I$(SWIG_DIR)/include $(SWIG_DIR)/src/example.cpp -o $(SWIG_DIR)/src/example.o
	g++ -shared $(SWIG_DIR)/src/example.o -o $(SWIG_DIR)/libexample.so

gen: lib
	swig -c++ -go -use-shlib -soname libexample.so $(SWIG_SRCS)

build: gen
	CGO_CPPFLAGS="-I$(SWIG_DIR)/include" CGO_LDFLAGS="-L$(SWIG_DIR) -l$(SWIG_DIR)" go build -o $(BINARY_NAME)

run: build
	LD_LIBRARY_PATH=$(SWIG_DIR) ./$(BINARY_NAME)

air: build
	LD_LIBRARY_PATH=$(SWIG_DIR) air

all: lib gen build

clean:
	rm -f $(BINARY_NAME)
	rm -f $(SWIG_WRAPPER)
	rm -f $(SWIG_GO_FILE)
	rm -f $(SWIG_DIR)/src/example.o
	rm -f $(SWIG_DIR)/libexample.so
