FROM    slothds/alpine-svd:3.9

LABEL   maintainer="SlothDS" \
        maintainer.mail="sloth@devils.su" \
        maintainer.git="https://github.com/slothds"

ENV     WDMRC_VERS="1.10.7.10" \
        WDMRC_REPO="https://github.com/yar229/WebDavMailRuCloud/releases/download" \
        WDMRC_HOME="/opt/runner" \
        WDMRC_PORT="8010" \
        WDMRC_HOST="http://*" \
        WDMRC_ARGS=""

RUN     apk add --no-cache --virtual .install-dep ca-certificates curl && \
        apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
        curl -kfsSL -o /tmp/wdmrc-core.zip \
            ${WDMRC_REPO}/${WDMRC_VERS}/WebDAVCloudMailRu-${WDMRC_VERS}-dotNet461.zip && \
        mkdir -p ${WDMRC_HOME} && \
        unzip /tmp/wdmrc-core.zip -d ${WDMRC_HOME} && \
        chown -R runner:runner ${WDMRC_HOME} && \
        cat /etc/ssl/certs/* > /tmp/ca-root.crt && \
        cert-sync /tmp/ca-root.crt && \
        apk del .install-dep && \
        rm -rf /tmp/* /var/cache/apk/* /var/tmp/*

COPY    rootfs /
