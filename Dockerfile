FROM tiredofit/nodejs:6-latest
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

### Disable Features From Base Image
ENV ENABLE_SMTP=false

### Install Dependencies
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add \
        gcc \
        g++ \
        make \
        mariadb-dev \
        && \

    apk add \
        dovecot \
        dovecot-ldap \
        python \
        rspamd@testing \
        wget

RUN cd /usr/src && \
    npm -g install \
        Haraka \
        iconv \
        mkdirp \
        mysql

ADD install /

EXPOSE 25 143 465 587 993 995
