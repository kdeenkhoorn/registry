FROM kdedesign/debian-stretch

MAINTAINER "k.eenkhoorn@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Create user and group account
RUN groupadd -g 2002 registry \
   && useradd -u 2002 -g 2002 -c "Docker registry user" -d /var/lib/registry  -s /bin/bash registry

# Create registry directories
RUN mkdir -p /var/lib/registry \
    && chown -R registry:registry /var/lib/registry \
    && mkdir -p /opt/registry

# Copy binaries and config
COPY ./workspace/bin/registry /opt/registry
COPY ./workspace/src/github.com/docker/distribution/cmd/registry/config-example.yml /opt/registry/config-registry.yml

# Correct ownership of recent copied files
RUN chown -R registry:registry /opt/registry

EXPOSE 5000

USER registry
CMD ["/opt/registry/registry", "serve", "/opt/registry/config-registry.yml"]
