
# Builder
FROM abiosoft/caddy:builder as builder

ARG version="0.11.0"
ARG plugins="git,filemanager,cors,realip,expires,cache,authz,jwt"

# process wrapper
RUN go get -v github.com/abiosoft/parent

# Builder
RUN VERSION=${version} PLUGINS=${plugins} /bin/sh /usr/bin/builder.sh


# Final stage
FROM alpine:3.8
LABEL maintainer "Thiago Zilli Sarmento <thiago.zilli@gmail.com>"

ARG version="0.11.0"
LABEL caddy_version="$version"

# Let's Encrypt Agreement
ENV ACME_AGREE="true"

RUN apk add --no-cache openssh-client git

# install caddy
COPY --from=builder /install/caddy /usr/bin/caddy

# validate install
RUN /usr/bin/caddy -version
RUN /usr/bin/caddy -plugins

EXPOSE 80 443 2015
VOLUME /root/.caddy /srv
WORKDIR /srv

RUN apk add bash bash-completion bash-doc

# install process wrapper
COPY --from=builder /go/bin/parent /bin/parent

#create a dir for config
RUN mkdir -p /var/caddyproxy

#copy startup or bootstrap
COPY /resources/startup.sh /var/caddyproxy/startup.sh

#Set timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#fireup
#ENTRYPOINT ["/bin/parent", "caddy"]
#CMD ["--conf", "/etc/Caddyfile", "--log", "stdout", "--agree=$ACME_AGREE"]
ENTRYPOINT ["/bin/bash", "-c" , "echo $(ip -4 route list match 0/0 | awk '{print $3}') host.docker.internal >> /etc/hosts && /var/caddyproxy/startup.sh"]
