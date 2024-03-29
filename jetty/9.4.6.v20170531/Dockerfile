FROM registry.tenfz.com/library/oraclejdk:8u131
MAINTAINER harold.zhou <haroldzz.zhou@gmail.com>

ARG JETTY_VERSION=9.4.6.v20170531
# ARG JETTY_TGZ_URL=https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-home/$JETTY_VERSION/jetty-home-${JETTY_VERSION}.tar.gz
ARG JETTY_TGZ_URL=http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${JETTY_VERSION}/jetty-distribution-${JETTY_VERSION}.tar.gz
ARG TMPDIR=/tmp/jetty

ENV JETTY_HOME /usr/local/jetty
ENV JETTY_BASE /var/lib/jetty
ENV PATH $JETTY_HOME/bin:$PATH

# GPG Keys are personal keys of Jetty committers (see https://github.com/eclipse/jetty.project/blob/0607c0e66e44b9c12a62b85551da3a0edce0281e/KEYS.txt)
ENV JETTY_GPG_KEYS \
	# Jan Bartel      <janb@mortbay.com>
	AED5EE6C45D0FE8D5D1B164F27DED4BF6216DB8F \
	# Jesse McConnell <jesse.mcconnell@gmail.com>
	2A684B57436A81FA8706B53C61C3351A438A3B7D \
	# Joakim Erdfelt  <joakim.erdfelt@gmail.com>
	5989BAF76217B843D66BE55B2D0E1FB8FE4B68B4 \
	# Joakim Erdfelt  <joakim@apache.org>
	B59B67FD7904984367F931800818D9D68FB67BAC \
	# Joakim Erdfelt  <joakim@erdfelt.com>
	BFBB21C246D7776836287A48A04E0C74ABB35FEA \
	# Simone Bordet   <simone.bordet@gmail.com>
	8B096546B1A8F02656B15D3B1677D141BCF3584D \
	# Greg Wilkins    <gregw@webtide.com>
	FBA2B18D238AB852DF95745C76157BDF03D0DCD6 \
	# Greg Wilkins    <gregw@webtide.com>
	5C9579B3DB2E506429319AAEF33B071B29559E1E

WORKDIR $JETTY_HOME
COPY docker-entrypoint.sh /
RUN set -xe \
	&& mkdir -p "$JETTY_HOME" \
	&& mkdir -p "$JETTY_BASE" \
	&& mkdir -p "$TMPDIR" \	
	&& groupadd -g 1000 jetty && useradd -u 1000 -g jetty jetty \
	&& chmod +x /docker-entrypoint.sh \
	&& curl --location --retry 3 -o jetty.tar.gz "$JETTY_TGZ_URL" \
	&& curl --location --retry 3 -o jetty.tar.gz.asc "$JETTY_TGZ_URL.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& for key in $JETTY_GPG_KEYS; do \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; done \
	&& gpg --batch --verify jetty.tar.gz.asc jetty.tar.gz \
	&& rm -rf "$GNUPGHOME" \
	&& tar -zxf jetty.tar.gz --strip-components=1 \
	&& sed -i '/jetty-logging/d' etc/jetty.conf \
	&& sed -i '/minThreads/ s/10/100/' etc/jetty.xml \
	&& sed -i '/maxThreads/ s/200/300/' etc/jetty.xml \
	&& sed -i '/idleTimeout/ s/60000/6000/' etc/jetty.xml \
	&& java -jar "$JETTY_HOME/start.jar" --create-startd --add-to-start="server,http,deploy,jsp,jstl,ext,resources,websocket,setuid" \
	&& chown -R jetty:jetty "$JETTY_HOME" \
	&& chown -R jetty:jetty "$JETTY_BASE" \
	&& chown -R jetty:jetty "$TMPDIR" \
	&& rm jetty.tar.gz* \
	&& rm -rf /tmp/hsperfdata_root

EXPOSE 8080
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java","-jar","/usr/local/jetty/start.jar"]
