#FROM    slothds/debian-svd:stretch
FROM    dotnet

LABEL   maintainer="sloth@devils.su"

ENV     WDMRC_VERS=1.10.0.4
ENV     WDMRC_HOME=/opt/home/wdmrc

COPY    rootfs /

RUN apt-get update && apt -y install wget unzip 
RUN     wget --no-check-certificate https://github.com/yar229/WebDavMailRuCloud/releases/download/${WDMRC_VERS}/WebDAVCloudMailRu-${WDMRC_VERS}-dotNet45.zip -O /tmp/wdmrc-core.zip && \
        mkdir -p ${WDMRC_HOME} && \
        unzip /tmp/wdmrc-core.zip -d ${WDMRC_HOME} && \
        rm -rf /tmp/*
ENTRYPOINT ["/usr/bin/mono", "/usr/lib/mono/4.5/mono-service.exe", "/opt/home/wdmrc/wdmrc.exe", "-h", "http://*", "-p", "801"]

EXPOSE  801
