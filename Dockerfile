FROM    slothds/alpine-svd:3.12

ARG     WDMRC_REPO="https://github.com/yar229/WebDavMailRuCloud/releases/download"
ARG     WDMRC_VERS="1.11.0.30"
ARG     WDMRC_DNET="dotNetCore30"
ARG     WDMRC_HOME="/opt/runner"

ARG     NCORE_VERS="3.1.8"
ARG     NCORE_LINK="https://dotnet.microsoft.com/download/dotnet-core/thank-you/runtime-${NCORE_VERS}-linux-x64-alpine-binaries"

ENV     WDMRC_HOST="http://*" \
        WDMRC_PORT="8010" \
        WDMRC_ARGS=""

RUN     apk add --no-cache --virtual .install-dep ca-certificates curl && \
        apk add --no-cache \
                           icu-libs \
                           krb5-libs \
                           libintl \
                           libssl1.1 \
                           libstdc++ \
                           lttng-ust \
                           zlib \
        && \
        mkdir -p ${WDMRC_HOME}/dotnet && \
        curl -kfsSL $(curl -s ${NCORE_LINK} | sed -rn "s|.*<a href=\"(.*\.tar\.gz)\".*|\1|p;") \
            | tar -zx -C ${WDMRC_HOME}/dotnet && \
        curl -kfSL ${WDMRC_REPO}/${WDMRC_VERS}/WebDAVCloudMailRu-${WDMRC_VERS}-${WDMRC_DNET}.zip \
            -o /tmp/wdmrc-core.zip && \
        unzip /tmp/wdmrc-core.zip -d ${WDMRC_HOME} && \
        chown -R runner:runner ${WDMRC_HOME} && \
        apk del .install-dep && \
        rm -rf /tmp/* /var/cache/apk/* /var/tmp/*

COPY    rootfs /
