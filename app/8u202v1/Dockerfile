FROM uhub.service.docker.cn/basic/oraclejdk:8u202
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

ARG TMPDIR=/tmp/app

ENV APP_HOME /usr/local/app
ENV PATH $APP_HOME/bin:$PATH

WORKDIR $APP_HOME
COPY docker-entrypoint.sh /
COPY start.jar $APP_HOME/
RUN set -ex \
	&& yum install -y epel-release unzip && yum clean all \
	&& mkdir -p "$APP_HOME" \
	&& mkdir -p "$TMPDIR" \	
	&& groupadd -g 1000 app && useradd -u 1000 -g app app \
	&& chmod +x /docker-entrypoint.sh \
	&& chown -R app:app "$APP_HOME" \
	&& chown -R app:app "$TMPDIR" \
        && rm -rf /var/cache/yum/* && rm -rf /tmp/* && rm -rf /var/log/*

EXPOSE 8080
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java","-jar","/usr/local/app/start.jar"]
