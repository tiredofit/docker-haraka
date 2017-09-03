FROM tiredofit/nodejs:6-latest
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

### Install Dependencies
RUN apk update && \
 
    apk add \
        gcc \
        g++ \
        make \
        mariadb-dev \
        
        && \

    apk add \
        dovecot \
        dovecot-mysql \
        dovecot-ldap \
        python \
       # rspamd \
        wget

RUN cd /usr/src && \
    npm install \
        Haraka \
        mkdirp \
        mysql && \

