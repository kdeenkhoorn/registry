FROM kdedesign/debian-stretch:1.0.0

MAINTAINER "k.eenkhoorn@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Create user and group account
RUN groupadd -g 2002 registry
RUN useradd -u 2002 -g 2002 -c "Docker registry user" -d /var/lib/registry  -s /bin/bash registry


# Create registry directories
RUN mkdir -p /var/lib/registry
RUN chown -R registry:registry /var/lib/registry


EXPOSE 5000

USER registry
CMD ["/var/lib/registry/bin/registry", "serve", "/var/lib/registry/conf/config-registry.yml"]
