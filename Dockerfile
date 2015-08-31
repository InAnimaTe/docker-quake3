FROM debian:jessie

## The Data Installer from ioquake3. See http://ioquake3.org/get-it/
ENV ioquake_data ioquake3-q3a-1.32-9.run

RUN echo "deb http://httpredir.debian.org/debian jessie contrib" >> /etc/apt/sources.list && \
        apt-get update && \
        apt-get install -y quake3-server \
        wget && \
            apt-get clean

RUN rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/* \
        /var/cache/debconf/*-old \
        /var/lib/apt/lists/* \
        /usr/share/doc/*

WORKDIR /usr/games

RUN wget "http://ioquake3.org/files/1.36/data/${ioquake_data}.run" && \
        chmod +x ${ioquake_data} && \
        ./${ioquake_data} --tar xvf -C /usr/share/games/quake3/

USER Debian-quake3

EXPOSE 27960/udp

ENTRYPOINT ["/usr/games/quake3-server"]

CMD ["+exec server.cfg +map q3dm19"]
