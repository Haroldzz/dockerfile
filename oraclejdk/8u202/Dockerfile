FROM uhub.service.docker.cn/basic/centos:7.6.1810
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

# build parameters
ARG JAVA_DISTRIBUTION=jdk
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=202
ARG JAVA_BUILD_NUMBER=08
ARG JAVA_HASH=1961070e4c9b4e26a04e7f5a083f551e
ARG BUILD_DATE=undefined

ENV JAVA_VERSION=1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}
ENV JAVA_HOME=/opt/java/${JAVA_DISTRIBUTION}${JAVA_VERSION}
ENV PATH=$PATH:$JAVA_HOME/bin

# set workdir
WORKDIR /tmp

# install oracle jdk
RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum install -y epel-release unzip && yum clean all \
    && export JAVA_TARBALL=${JAVA_DISTRIBUTION}-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz \
    && [[ -n "${JAVA_HASH}" ]] && JAVA_HASH_EXTENTION=/$JAVA_HASH/ || JAVA_HASH_EXTENTION= \    
    && curl --location --retry 3 --remote-name \
    http://nas.1718281828.com/otn/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}${JAVA_HASH_EXTENTION}/${JAVA_TARBALL} \
    && mkdir -p /opt/java && tar -zxf /tmp/${JAVA_TARBALL} -C /opt/java/ \
    && alternatives --install /usr/bin/java java ${JAVA_HOME}/bin/java 100 \
    && rm -rf /var/cache/yum/* && rm -rf /tmp/* && rm -rf /var/log/*
