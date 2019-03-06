FROM ubuntu:18.04

RUN apt update &&\
    apt dist-upgrade -yq &&\
    apt install -y nodejs npm &&\
    npm install -g npm &&\
    npm install -g ssb-server

CMD ["bash", "-c", "while true ; do timeout 1h ssb-server start ; done"]