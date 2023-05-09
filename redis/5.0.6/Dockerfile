FROM uhub.service.docker.cn/basic/centos:7.6.1810
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

WORKDIR /tmp

ENV REDIS_VERSION 5.0.6
ENV REDIS_URL http://download.redis.io/releases/redis-5.0.6.tar.gz
ENV PATH /usr/local/redis/bin:$PATH

RUN set -ex \
    && yum install -y gcc openssl-devel readline-devel systemd-devel make \
    && curl -o redis.tar.gz -L "$REDIS_URL" \
    && mkdir -p /usr/local/src/redis \
    && tar -zxf redis.tar.gz -C /usr/local/src/redis --strip-components=1 \
    && rm -rf redis.tar.gz \
    && makeOpts="" \
    && nproc="$(nproc)" \
    && eval "make -C /usr/local/src/redis -j '$nproc' $makeOpts" \
    && eval "make -C /usr/local/src/redis PREFIX=/usr/local/redis install" \
    && mkdir -p /etc/redis \
    && cp /usr/local/src/redis/sentinel.conf /etc/redis/sentinel.conf \
    && cp /usr/local/src/redis/redis.conf /etc/redis/redis.conf


EXPOSE 6379
EXPOSE 26379
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["redis-server", "/etc/redis/redis.conf"]
