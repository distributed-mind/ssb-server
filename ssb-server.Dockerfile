FROM ubuntu:18.04

RUN apt update &&\
apt dist-upgrade -yq &&\
apt install -y \
  nodejs \
  npm \
  gettext-base \
  jq &&\
npm install -g npm &&\
npm install -g ssb-server &&\
rm -rf /var/lib/apt/lists/*

RUN adduser \
  --system \
  --disabled-password \
  --group \
  --gecos "" \
  --home /ssb \
  ssb &&\
chown ssb:ssb /ssb

COPY container-entrypoint /usr/local/bin/container-entrypoint

USER ssb
WORKDIR /ssb

VOLUME [ "/ssb" ]
ENTRYPOINT [ "/usr/local/bin/container-entrypoint" ]
# restart every hour
CMD ["bash", "-c", "while true ; do timeout 1h ssb-server start ; done"]
