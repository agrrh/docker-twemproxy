FROM alpine:3.6

EXPOSE 6379 6222

RUN apk --update add --virtual build-dependencies build-base git autoconf automake libtool \
  && cd /tmp \
  && git clone https://github.com/twitter/twemproxy.git \
  && cd twemproxy \
  && git checkout v0.4.0 \
  && autoreconf -fvi \
  && ./configure --prefix=/ \
  && make -j2 \
  && make install \
  && cd .. \
  && rm -fr twemproxy \
  && apk del build-dependencies

ENV REDIS_AUTH=""

# Copy and install resources
COPY twemproxy.yml.in run.sh /

CMD [ "/run.sh" ]
