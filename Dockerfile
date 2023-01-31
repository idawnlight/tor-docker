FROM docker.io/debian:bullseye-slim

RUN apt-get update \
    && apt-get install -y build-essential automake openssl libssl-dev libevent-dev zlib1g zlib1g-dev wget \
    && mkdir -p /tor/persist

RUN wget https://gitlab.torproject.org/tpo/core/tor/-/archive/tor-0.4.7.13/tor-tor-0.4.7.13.tar.gz \
    && tar -xvf *.tar.gz \
    && cd tor-* \
    && sh autogen.sh \
    && ./configure --disable-asciidoc \
    && make \
    && make install \
    && cd ../ \
    && rm -rf tor-*

WORKDIR /tor

CMD ["tor", "--datadirectory", "./persist", "-f", "torrc"]
