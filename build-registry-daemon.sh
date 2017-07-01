#!/bin/bash


echo "https://github.com/docker/distribution/blob/master/BUILDING.md for more info" 
GOPATH=/home/klaas/docker/registry/workspace
export GOPATH


go get github.com/docker/distribution/cmd/registry

