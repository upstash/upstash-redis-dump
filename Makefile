#!/usr/bin/make

.PHONY: test build

all: test build

test:
	go test ./...
	go vet ./...

build:
	go build -o bin/upstash-redis-dump

release:
	mkdir -p dist
	GOOS=linux GOARCH=amd64 go build && zip -m dist/upstash-redis-dump_linux_amd64.zip upstash-redis-dump
	GOOS=linux GOARCH=arm64 go build && zip -m dist/upstash-redis-dump_linux_arm64.zip upstash-redis-dump
	GOOS=darwin GOARCH=amd64 go build && zip -m dist/upstash-redis-dump_macos_amd64.zip upstash-redis-dump
	GOOS=darwin GOARCH=arm64 go build && zip -m dist/upstash-redis-dump_macos_arm64.zip upstash-redis-dump
	GOOS=windows GOARCH=amd64 go build && zip -m dist/upstash-redis-dump_windows_amd64.zip upstash-redis-dump.exe
