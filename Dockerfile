FROM    slothds/alpine-svd:3.12

ARG     WDMRC_REPO="https://github.com/yar229/WebDavMailRuCloud/releases"
ARG     WDMRC_HOME="/opt/runner"
ARG     NCORE_LVER="3.1.10"

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
        # NCORE_LVER=$(\
        #     curl -sL $(\
        #         curl -sL https://dotnet.microsoft.com/download/dotnet-core|\
        #         sed -rn 's|^.*<a href="(.*)" .*> \(recommended\).*$|https://dotnet.microsoft.com\1|p;'\
        #     )|sed -rn 's|^.*<h2.*id="([[:digit:].]*)">.*</h2>.*$|\1|p;'|head -n1) && \
        NCORE_LINK="https://dotnet.microsoft.com/download/dotnet-core/thank-you/runtime-${NCORE_LVER}-linux-x64-alpine-binaries" && \
        echo "Download .Net Core v${NCORE_LVER}" && \
        curl -kfSL $(curl -sL ${NCORE_LINK} | sed -rn "s|.*<a href=\"(.*\.tar\.gz)\".*|\1|p;") \
            | tar -zx -C ${WDMRC_HOME}/dotnet && \
        WDMRC_LVER=$(curl -sL ${WDMRC_REPO}/latest | sed -rn 's|.*<a.*WebDAVCloudMailRu-([.[:digit:]]*)-dotNetCore.*|\1|p;') \
        && \
        WDMRC_DNET=$(curl -sL ${WDMRC_REPO}/latest | sed -rn 's|.*<a.*WebDAVCloudMailRu-.*(dotNetCore[[:digit:]]*)\.zip.*|\1|p;') \
        && \
        echo "Download WebDavMailRuCloud v${WDMRC_LVER}-${WDMRC_DNET}" && \
        curl -kfSL ${WDMRC_REPO}/download/${WDMRC_LVER}/WebDAVCloudMailRu-${WDMRC_LVER}-${WDMRC_DNET}.zip \
            -o /tmp/wdmrc-core.zip && \
        unzip /tmp/wdmrc-core.zip -d ${WDMRC_HOME} && \
        chown -R runner:runner ${WDMRC_HOME} && \
        apk del .install-dep && \
        rm -rf /tmp/* /var/cache/apk/* /var/tmp/*

COPY    rootfs /
