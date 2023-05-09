FROM uhub.service.docker.cn/basic/centos:7.6.1810
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

# Build parameters
# Allow build-time overrides (eg. to build image with rabbitmq version)
# Options for RABBIT_PACKAGE: rabbitmq-server
# Options for RABBIT_BASE_REPO: dl.bintray.com OR another
# Example: docker build --build-arg RABBIT_PACKAGE=rabbitmq-server --build-arg RABBIT_BASE_REPO=
ARG CENTOS_MAJOR_VERSION=7
ARG RABBIT_PACKAGE=rabbitmq-server
ARG RABBIT_MAJOR=3.8
ARG RABBIT_VERSION=3.8.1
ARG RABBIT_BASE_REPO=https://dl.bintray.com/rabbitmq/rpm/${RABBIT_PACKAGE}/v${RABBIT_MAJOR}.x/el/${CENTOS_MAJOR_VERSION}/
ARG RABBIT_SIGNING_KEYS=https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc

ARG ERLANG_PACKAGE=rabbitmq-erlang
ARG ERLANG_MAJOR=22
ARG ERLANG_VERSION=22.1.7
ARG ERLANG_BASE_REPO=https://dl.bintray.com/${ERLANG_PACKAGE}/rpm/erlang/${ERLANG_MAJOR}/el/${CENTOS_MAJOR_VERSION}/
ARG ERLANG_SIGNING_KEYS=https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc


# set workdir
WORKDIR /tmp

# install rabbit
COPY docker-entrypoint.sh /
RUN set -ex \
    && echo -e "[${RABBIT_PACKAGE}]\n\
name=Rabbitmq Repository\n\
baseurl=${RABBIT_BASE_REPO}\n\
gpgcheck=1\n\
enabled=1\n"\
>> /etc/yum.repos.d/${RABBIT_PACKAGE}.repo \
    && echo -e "[${ERLANG_PACKAGE}]\n\
name=Rabbitmq Erlang Repository\n\
baseurl=${ERLANG_BASE_REPO}\n\
gpgcheck=1\n\
enabled=1\n"\
>> /etc/yum.repos.d/${ERLANG_PACKAGE}.repo \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && chmod +x /docker-entrypoint.sh \
    && rpm --import "${RABBIT_SIGNING_KEYS}" \
    && yum install -y erlang-${ERLANG_VERSION} rabbitmq-server-${RABBIT_VERSION} \
    && yum install -y epel-release unzip && yum clean all \
    && rm -rf /var/cache/yum/* && rm -rf /tmp/*

EXPOSE 5672 15672 4369 25672
USER rabbitmq
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["rabbitmq-server"]
