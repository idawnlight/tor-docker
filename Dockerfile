FROM docker.io/debian:bullseye-slim

RUN awk '{ print $1" "$2" "$3" "$4; print $1"-src "$2" "$3" "$4 }' /etc/apt/sources.list > temp.file && mv temp.file /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y build-essential automake git \
    && apt-get build-dep -y tor \
    && apt-get install -y $(apt-cache depends tor | awk '$1~/Depends/{printf $2" "}') \
    && mkdir -p /tor/persist

RUN cd /tmp \
    && git clone --depth 1 --branch tor-0.4.7.13 https://gitlab.torproject.org/tpo/core/tor.git \
    && cd tor \
    && ./autogen.sh \
    && ./configure --enable-lzma --enable-zstd \
    && make -j2 \
    && make install \
    && cd ../ \
    && rm -rf tor

WORKDIR /tor

CMD ["tor", "--datadirectory", "./persist", "-f", "torrc"]
