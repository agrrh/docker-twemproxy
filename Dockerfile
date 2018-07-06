FROM alpine:3.6

ENV TWEMPROXY_VERSION 0.4.1

EXPOSE 6379 6222

RUN apk --update add --virtual build-dependencies build-base git autoconf automake libtool \
  && cd /tmp \
  && git clone https://github.com/twitter/twemproxy.git \
  && cd twemproxy \
  && git checkout v${TWEMPROXY_VERSION} \
  && autoreconf -fvi \
  && ./configure --prefix=/ \
  && make -j2 \
  && make install \
  && cd .. \
  && rm -fr twemproxy \
  && apk del build-dependencies

ENV REDIS_AUTH=""

COPY twemproxy.yml /

CMD nutcracker -c /twemproxy.yml -v 7 -s 6222
