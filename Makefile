#!/usr/bin/make

.PHONY: test build

all: test build

test:
	go test ./...
	go vet ./...

build:
	go build -o bin/redis-dump
