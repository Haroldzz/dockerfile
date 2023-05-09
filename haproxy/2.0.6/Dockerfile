FROM uhub.service.docker.cn/basic/centos:7.6.1810
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

WORKDIR /tmp

ENV HAPROXY_VERSION 2.0.6
ENV HAPROXY_URL https://www.haproxy.org/download/2.0/src/haproxy-2.0.6.tar.gz
ENV HAPROXY_SHA256 01e1da09452010111107ca1b3a8b7f1927731ba0fe4380bacae1c626fdc521e4
ENV LUA_VERSION 5.3.5
ENV LUA_URL https://www.lua.org/ftp/lua-5.3.5.tar.gz
ENV LUA_SHA256 0c2eed3f960446e1a3e4b9a1ca2f3ff893b6ce41942cf54d5dd59ab4b3b058ac
ENV PATH /usr/local/haproxy/sbin:$PATH

RUN set -ex \
    && yum install -y gcc openssl-devel readline-devel systemd-devel make pcre2-devel \
    && curl -o haproxy.tar.gz -L "$HAPROXY_URL" \
    && curl -o lua.tar.gz -L "$LUA_URL" \
    && echo "$HAPROXY_SHA256 haproxy.tar.gz" | sha256sum -c \
    && echo "$LUA_SHA256 lua.tar.gz" | sha256sum -c \
    && mkdir -p /usr/local/src/haproxy \
    && tar -zxf haproxy.tar.gz -C /usr/local/src/haproxy --strip-components=1 \
    && rm -rf haproxy.tar.gz \
    && mkdir -p /usr/local/src/lua \
    && tar -zxf lua.tar.gz -C /usr/local/src/lua --strip-components=1 \
    && rm -rf lua.tar.gz \
    && makeOpts=' \
        TARGET=linux-glibc \
        USE_OPENSSL=1 \
        USE_PCRE2=1 USE_PCRE2_JIT=1 \
        USE_ZLIB=1 \
        USE_LIBCRYPT=1 \
        USE_THREAD=1 \
        USE_GETADDRINFO=1 \
        USE_LUA=1 LUA_INC="/usr/local/lua/include" LUA_LIB="/usr/local/lua/lib" \
        EXTRA_OBJS="contrib/prometheus-exporter/service-prometheus.o" \
        ' \
    && nproc="$(nproc)" \
    && eval "make -C /usr/local/src/lua INSTALL_TOP=/usr/local/lua linux install" \
    && eval "make -C /usr/local/src/haproxy -j '$nproc' $makeOpts" \
    && eval "make -C /usr/local/src/haproxy PREFIX=/usr/local/haproxy install" \
    && mkdir -p /etc/haproxy \
    && cp -R /usr/local/src/haproxy/examples/errorfiles /etc/haproxy/errors \
    && cp /usr/local/src/haproxy/tests/test-url-hash.cfg /etc/haproxy/haproxy.cfg


EXPOSE 80
EXPOSE 443
EXPOSE 27182
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]
