FROM debian:stretch-slim
LABEL maintainer="Markus Kosmal <dude@m-ko.de> https://m-ko.de"

# Debian Base to use
ENV DEBIAN_VERSION stretch

RUN echo "deb http://http.debian.net/debian/ $DEBIAN_VERSION main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://http.debian.net/debian/ $DEBIAN_VERSION-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ $DEBIAN_VERSION/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y -qq \
        clamav-daemon \
        clamav-freshclam \
        libclamunrar7 \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget -O /var/lib/clamav/main.cvd http://database.clamav.net/main.cvd \
    && wget -O /var/lib/clamav/daily.cvd http://database.clamav.net/daily.cvd \
    && wget -O /var/lib/clamav/bytecode.cvd http://database.clamav.net/bytecode.cvd \
    && mkdir /var/run/clamav \
    && sed -i 's/^Foreground .*$/Foreground true/g' /etc/clamav/clamd.conf \
    && sed -i '/LocalSocketGroup/d' /etc/clamav/clamd.conf \
    && echo "TCPSocket 3310" >> /etc/clamav/clamd.conf \
    && if ! [ -z $HTTPProxyServer ]; then echo "HTTPProxyServer $HTTPProxyServer" >> /etc/clamav/freshclam.conf; fi \
    && if ! [ -z $HTTPProxyPort   ]; then echo "HTTPProxyPort $HTTPProxyPort" >> /etc/clamav/freshclam.conf; fi \
    && sed -i 's/^Foreground .*$/Foreground true/g' /etc/clamav/freshclam.conf \
    && chgrp -R 0 /var/log/clamav /var/lib/clamav /run/clamav /var/run/clamav \
    && chmod -R g=u /var/log/clamav /var/lib/clamav /run/clamav /var/run/clamav \
    && chmod -R 774 /var/log/clamav /var/lib/clamav /run/clamav /var/run/clamav

# volume provision, comment out otherwise can not change group to root
VOLUME ["/var/lib/clamav"]

# port provision
EXPOSE 3310

# av daemon bootstrapping
ADD bootstrap.sh /
CMD ["/bootstrap.sh"]

USER 1001
