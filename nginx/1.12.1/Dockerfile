FROM uhub.service.docker.cn/basic/centos:7.6.1810
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

# build parameters
ARG NGINX_BASE_REPO=http://nginx.org/packages/centos
ARG CENTOS_MAJOR_VERSION=7
ARG NGINX_REPO_RPM=nginx-release-centos-7-0.el7.ngx.noarch.rpm

# set workdir
WORKDIR /tmp

# install nginx
COPY docker-entrypoint.sh /
RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && mkdir /usr/local/web \
    && chmod +x /docker-entrypoint.sh \
    && curl --location --retry 3 --remote-name ${NGINX_BASE_REPO}/${CENTOS_MAJOR_VERSION}/noarch/RPMS/${NGINX_REPO_RPM} \
    && yum localinstall -y ${NGINX_REPO_RPM} \
    && yum install -y epel-release nginx unzip && yum clean all \
    && rm -rf /var/cache/yum/* && rm -rf /tmp/*

EXPOSE 80
EXPOSE 443
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
