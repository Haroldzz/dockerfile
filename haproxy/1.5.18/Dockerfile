FROM uhub.service.docker.cn/basic/centos:7.6.1810
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

# set workdir
WORKDIR /tmp

# install haproxy
COPY docker-entrypoint.sh /
RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && mkdir /usr/local/app \
    && chmod +x /docker-entrypoint.sh \
    && yum install -y epel-release haproxy unzip && yum clean all \
    && rm -rf /var/cache/yum/* && rm -rf /tmp/*

EXPOSE 80
EXPOSE 443
EXPOSE 27182
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]
