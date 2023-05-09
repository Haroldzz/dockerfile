FROM uhub.service.docker.cn/basic/centos:7.6.1810
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

# build parameters
ARG NGINX_BASE_REPO=http://nginx.org/packages/centos
ARG CENTOS_MAJOR_VERSION=7
ARG NGINX_REPO_RPM=nginx-1.16.1-1.el7.ngx.x86_64.rpm

# set workdir
WORKDIR /tmp

# install nginx
COPY docker-entrypoint.sh /
RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && chmod +x /docker-entrypoint.sh \
    && yum install -y ${NGINX_BASE_REPO}/${CENTOS_MAJOR_VERSION}/x86_64/RPMS/${NGINX_REPO_RPM} \
    && yum install -y epel-release unzip && yum clean all \
    && rm -rf /var/cache/yum/* && rm -rf /tmp/*

EXPOSE 80
EXPOSE 443
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
