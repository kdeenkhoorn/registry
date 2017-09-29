#!/bin/bash

docker run --name registry --restart always -d -p 5000:5000 -v /data/docker/registry:/var/lib/registry kdedesign/registry
