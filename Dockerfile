FROM golang:1.8.3-alpine

MAINTAINER Thiago Zilli Sarmento <thiago.zilli@gmail.com>

#user to fireup
USER root

#env version of caddy and arch
LABEL caddy_version="0.10.4" architecture="amd64"

#Set timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# running apk add
RUN apk add --no-cache git bash build-base

# install caddyplug
RUN go get -v github.com/abiosoft/caddyplug/caddyplug \
 && mv /go/bin/caddyplug /usr/bin/caddyplug \
 && /usr/bin/caddyplug list

# install caddy using caddyplug
RUN /usr/bin/caddyplug install-caddy

EXPOSE 80 443 2015

#VOLUME /root/.caddy
VOLUME ["/root/.caddy", "/.caddy"]

#create a dir for config
RUN mkdir -p /var/caddyproxy

#copy startup or bootstrap
COPY /resources/startup.sh /var/caddyproxy/startup.sh

#fireup
ENTRYPOINT ["/bin/sh", "-c" , "echo $(ip -4 route list match 0/0 | awk '{print $3}') host.docker.internal >> /etc/hosts && exec /var/caddyproxy/startup.sh"]
