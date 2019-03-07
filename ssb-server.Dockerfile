FROM ubuntu:18.04

RUN apt update &&\
    apt dist-upgrade -yq &&\
    apt install -y nodejs npm &&\
    npm install -g npm &&\
    npm install -g ssb-server

RUN mkdir -p /data ;\
    ln -s /data /root/.ssb

COPY container-entrypoint /usr/local/bin/container-entrypoint

VOLUME [ "/data" ]
ENTRYPOINT [ "container-entrypoint" ]
CMD ["bash", "-c", "while true ; do timeout 1h ssb-server start ; done"]