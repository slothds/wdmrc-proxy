FROM   slothds/alpine-svd:3.7

LABEL  maintainer="sloth@devils.su"

ENV    WDMRC_VERS=1.10.1.10
ENV    WDMRC_HOME=/opt/home/wdmrc

COPY   rootfs /

RUN    apk update && apk upgrade --no-cache && \
       apk add --no-cache ca-certificates wget unzip && \
       apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
       rm -rf /tmp/* /var/cache/apk/* /var/tmp/*
RUN    wget --no-check-certificate https://github.com/yar229/WebDavMailRuCloud/releases/download/${WDMRC_VERS}/WebDAVCloudMailRu-${WDMRC_VERS}-dotNet45.zip -O /tmp/wdmrc-core.zip && \
       mkdir -p ${WDMRC_HOME} && \
       unzip /tmp/wdmrc-core.zip -d ${WDMRC_HOME} && \
       chown -R runner:runner ${WDMRC_HOME} && \
       cat /etc/ssl/certs/* > /tmp/ca-root.crt && \
       cert-sync /tmp/ca-root.crt && \
       rm -f /tmp/*

EXPOSE 8081
