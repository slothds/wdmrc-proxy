FROM   slothds/debian-svd:stretch

LABEL  maintainer="SlothDS" \
       maintainer.mail="sloth@devils.su" \
       maintainer.git="https://github.com/slothds"

ENV    WDMRC_VERS="1.10.1.11" \
       WDMRC_REPO="https://github.com/yar229/WebDavMailRuCloud/releases/download" \
       WDMRC_HOME="/opt/home/wdmrc"

COPY   rootfs /

RUN    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
                   --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
       apt-get update && apt-get -y upgrade && \
       apt-get -y install --no-install-recommends \
                          wget unzip mono-runtime mono-devel && \
       wget --no-check-certificate -O /tmp/wdmrc-core.zip \
            ${WDMRC_REPO}/${WDMRC_VERS}/WebDAVCloudMailRu-${WDMRC_VERS}-dotNet45.zip && \
       mkdir -p ${WDMRC_HOME} && \
       unzip /tmp/wdmrc-core.zip -d ${WDMRC_HOME} && \
       chown -R runner:runner ${WDMRC_HOME} && \
       apt-get -y remove --purge wget unzip && \
       apt-get -y autoremove && apt-get -y autoclean && \
       apt-get -y clean && apt-get -y clean all && \
       rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

EXPOSE 8081
