FROM uhub.service.docker.cn/basic/centos:7.6.1810
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

# Build parameters
# Allow build-time overrides (eg. to build image with MongoDB Enterprise version)
# Options for MONGO_PACKAGE: mongodb-org OR mongodb-enterprise
# Options for MONGO_BASE_REPO: repo.mongodb.org OR repo.mongodb.com
# Example: docker build --build-arg MONGO_PACKAGE=mongodb-enterprise --build-arg MONGO_REPO=repo.mongodb.com .
ARG MONGO_PACKAGE=mongodb-org
ARG CENTOS_MAJOR_VERSION=7
ARG MONGO_MAJOR=4.2
ARG MONGO_VERSION=4.2.1
ARG MONGO_BASE_REPO=https://repo.mongodb.org/yum/redhat/${CENTOS_MAJOR_VERSION}/${MONGO_PACKAGE}/${MONGO_MAJOR}/x86_64/
# "MongoDB 4.2 Release Signing Key <packaging@mongodb.com>"
ARG MONGO_GPG_KEYS=058F8B6B

# set workdir
WORKDIR /tmp

# install mongo
COPY docker-entrypoint.sh /
RUN set -ex \
    && echo -e "[${MONGO_PACKAGE}]\n\
name=MongoDB Repository\n\
baseurl=${MONGO_BASE_REPO}\n\
gpgcheck=1\n\
enabled=1\n\
gpgkey=https://www.mongodb.org/static/pgp/server-${MONGO_MAJOR}.asc\n"\
>> /etc/yum.repos.d/${MONGO_PACKAGE}.repo \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && chmod +x /docker-entrypoint.sh \
    && curl --location --retry 3 -o server-${MONGO_MAJOR}.asc "https://www.mongodb.org/static/pgp/server-${MONGO_MAJOR}.asc" \
    && gpg --import server-${MONGO_MAJOR}.asc \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "${MONGO_GPG_KEYS}" \
    && rpmkeys --import server-${MONGO_MAJOR}.asc \
    && yum install -y ${MONGO_PACKAGE}-${MONGO_VERSION} \
    && sed -i 's/fork: true/fork: false/g' /etc/mongod.conf \
    && yum install -y epel-release unzip && yum clean all \
    && rm -rf /var/cache/yum/* && rm -rf /tmp/*

EXPOSE 27017
USER mongod
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["mongod", "-f", "/etc/mongod.conf"]
