# Registry
This docker image is an armhf version of Docker private repository v2.0 based on my own debian 9 linux image.

## Image dependencies:
- One volume: /var/lib/registry required for persistent storage
- Port: 5000 for HTTP access to the repository daemon.
- User: registry (uid: 2002)
- Group: registry (gid: 2002)

## Typical run command:
- $ docker container run --name registry --restart always -d -p 5000:5000  -v /data/docker/registry:/var/lib/registry kdedesign/registry

## Build characteristics:
- Debian 9 (kdedesign/debian-stretch:1.0)
- Go 1.10 (go1.10.linux-armv6l.tar.gz)
- Repository v2.0 (https://github.com/docker/distribution/tree/master/cmd/registry)

## Repository build command:
- go build https://github.com/docker/distribution/tree/master/cmd/registry

## More info:
- Check https://github.com/kdeenkhoorn/registry

Have fun!

Kl@@s

