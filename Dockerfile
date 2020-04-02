FROM openjdk:8-jre-slim

ENV MPUSH_HOME /mpush
ENV MPUSH_VERSION 0.8.0
EXPOSE 3000 3001 3002

WORKDIR /

RUN set -x \
    && apt-get update && DEBIAN_FRONTEND=nointeractive apt-get install -y --no-install-recommends \
       wget ;\
       rm -rf /var/lib/apt/lists/* \
    && wget -O /tmp/mpush-release-${MPUSH_VERSION}.tar.gz \
       "https://github.com/mpusher/mpush/releases/download/v${MPUSH_VERSION}/mpush-release-${MPUSH_VERSION}.tar.gz" \
    && tar zxf /tmp/mpush-release-${MPUSH_VERSION}.tar.gz \
    && mv mpush-${MPUSH_VERSION} ${MPUSH_HOME} \
    && chmod +x ${MPUSH_HOME}/bin/*.sh \
    && rm /tmp/mpush-release-${MPUSH_VERSION}.tar.gz

VOLUME "${MPUSH_HOME}"
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
