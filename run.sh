#!/bin/bash

docker container run --name registry --restart always -d -p 5000:5000 \
       -v /data/docker/registry:/var/lib/registry cubian.phantasyworld.intern:5000/kdedesign/registry
