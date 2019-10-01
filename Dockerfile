FROM postgres:11-alpine

ENV CSTORE_FWD_VERSION=v1.6.2

RUN apk add --no-cache \
    git \
    libc-dev \
    protobuf-c-dev \
    protobuf-c \
    postgresql-dev \
    make \
    gcc \
    sed

RUN git clone -b "$CSTORE_FWD_VERSION" https://github.com/citusdata/cstore_fdw.git /tmp/cstore_fdw

RUN cd /tmp/cstore_fdw && PATH=/usr/local/pgsql/bin/:$PATH make && \
    PATH=/usr/local/pgsql/bin/:$PATH make install

RUN mkdir -p /etc/postgresql/ && \
    cp /usr/local/share/postgresql/postgresql.conf.sample /etc/postgresql/postgresql.conf

RUN sed -i "s/#shared_preload_libraries = ''/shared_preload_libraries = 'cstore_fdw'/g" /etc/postgresql/postgresql.conf

RUN echo "CREATE EXTENSION cstore_fdw;" >> /docker-entrypoint-initdb.d/cstore_init.sql
RUN echo "CREATE SERVER cstore_server FOREIGN DATA WRAPPER cstore_fdw;" >> /docker-entrypoint-initdb.d/cstore_init.sql

RUN apk del --no-cache \
    git \
    libc-dev \
    protobuf-c \
    postgresql-dev \
    make \
    gcc \
    sed
