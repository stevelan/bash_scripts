#! /bin/bash
# Gall - Go all, defaults to a set of go tools if no make file detected... TODO build makefile detection
echo "Galling - No make file detected - (fmt, vet, golint, build)"
go fmt ./... && go vet ./... && golint ./... && go build && echo "Go built successfully"
