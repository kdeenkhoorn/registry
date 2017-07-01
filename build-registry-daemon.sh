#!/bin/bash
# Useful one-liner which will give you the full directory name of the script no matter where it is being called from.
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo "Executiondir: ${DIR}"
GOPATH=${DIR}/workspace
export GOPATH

echo "Builddir    : ${GOPATH}"

echo "Cleaning workspace ..."
rm -rf ${GOPATH}/bin ${GOPATH}/pkg ${GOPATH}/src

echo "https://github.com/docker/distribution/blob/master/BUILDING.md for more info"
echo "Start build ..."
go get github.com/docker/distribution/cmd/registry
echo "Build finished ..."

