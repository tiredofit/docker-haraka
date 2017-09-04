FROM tiredofit/nodejs:6-latest
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

### Disable Features From Base Image
    ENV ENABLE_SMTP=false

### Install Build Dependencies
    RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
        apk update && \
        apk add --virtual haraka-build-dependencies \
            gcc \
            g++ \
            libpcap-dev \
            make \
            mariadb-dev \
            musl-dev \
            && \

### Install Runtime Dependencies
        apk add \
            curl \
            libpcap \
            python \
            rspamd@testing \
            tar \
            wget \
            && \

#### Install Haraka
        cd /usr/src && \
        npm -g install \
            Haraka \
            haraka-plugin-geoip \
            haraka-plugin-limit \
            haraka-plugin-p0f \
            iconv \
            maxmind-geolite-mirror \
            mkdirp \
            mysql \
            toobusy-js \
            && \


#### Install p0f
        mkdir -p /usr/src/p0f && \
        curl http://lcamtuf.coredump.cx/p0f3/releases/p0f-3.09b.tgz | tar xzvf - --strip 1 -C /usr/src/p0f && \
        cd /usr/src/p0f && \
        ./build.sh && \
        cp p0f /usr/sbin/ && \
        cp p0f.fp /etc/p0f.fp && \
                
### Add User
        addgroup haraka && \
        adduser -S \
                -D -G haraka \
                -h /data/ \
            haraka && \

### Misc & Cleanup
            ln -s /data/geoip /usr/local/share/GeoIP && \
            apk del --purge haraka-build-dependencies && \
            rm -rf /var/cache/apk/* /usr/src/*

### Add Files
    ADD install /

### Networking Configuration
    EXPOSE 25 143 465 587 993 995
