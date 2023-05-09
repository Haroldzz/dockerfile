FROM uhub.service.docker.cn/basic/centos:7.6.1810
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

# Build parameters
# Allow build-time overrides (eg. to build image with mariadb version)
# Options for MARIA_PACKAGE: MariaDB-server
# Options for MARIA_BASE_REPO: yum.mariadb.org OR another
# Example: docker build --build-arg MARIA_PACKAGE=MariaDB-server --build-arg MARIA_BASE_REPO=
ARG CENTOS_MAJOR_VERSION=7
ARG MARIA_PACKAGE=MariaDB-server
ARG MARIA_MAJOR=10.4
ARG MARIA_VERSION=10.4.10
ARG MARIA_BASE_REPO=http://yum.mariadb.org/${MARIA_MAJOR}/rhel7-amd64


# set workdir
WORKDIR /tmp

# install mariadb
COPY docker-entrypoint.sh /
RUN set -ex \
    && echo -e "[${MARIA_PACKAGE}]\n\
name=MariaDB Repository\n\
baseurl=${MARIA_BASE_REPO}\n\
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\n\
gpgcheck=1\n\
enabled=1\n"\
>> /etc/yum.repos.d/${MARIA_PACKAGE}.repo \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && chmod +x /docker-entrypoint.sh \
    && yum install -y ${MARIA_PACKAGE}-${MARIA_VERSION} \
    && yum install -y epel-release unzip && yum clean all \
    && rm -rf /var/cache/yum/* && rm -rf /tmp/*

EXPOSE 3306
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["mysqld_safe"]
