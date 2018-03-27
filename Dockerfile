FROM kdedesign/debian-stretch AS build

# Update basic OS image
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Start specific part for this first stage of the build
WORKDIR /opt
ENV GOPATH=/opt

ADD https://dl.google.com/go/go1.10.linux-armv6l.tar.gz /opt/go1.10.linux-armv6l.tar.gz

RUN apt-get update \
    && apt-get install -y git gcc \
    && tar -zxf ./go1.10.linux-armv6l.tar.gz \
    && /opt/go/bin/go get github.com/docker/distribution/cmd/registry

# Start second stage of the build
# Build final image

FROM kdedesign/debian-stretch

# Update basic OS image
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

RUN groupadd -g 2002 registry \
    && useradd -u 2002 -g 2002 -c "Docker registry user" -d /var/lib/registry  -s /bin/bash registry \
    && mkdir -p /var/lib/registry \
    && mkdir -p /opt/registry \
    && chown -R registry:registry /var/lib/registry \
    && chown -R registry:registry /opt/registry

# Copy binaries and config from first stage build
COPY --chown=2002:2002 --from=build /opt/bin/registry /opt/registry
COPY --chown=2002:2002 --from=build /opt/src/github.com/docker/distribution/cmd/registry/config-example.yml /opt/registry/config-registry.yml

VOLUME ["/var/lib/registry"]
EXPOSE 5000
USER registry
ENTRYPOINT ["/opt/registry/registry"]
CMD ["serve", "/opt/registry/config-registry.yml"]
