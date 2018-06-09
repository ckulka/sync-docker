ARG FROM_ARCH=amd64
FROM ${FROM_ARCH}/ubuntu:18.04

ARG ARCH=x64
ARG VERSION=2.5.13

LABEL Resilio Inc. <support@resilio.com>
LABEL com.resilio.version="${VERSION}"

ADD https://download-cdn.resilio.com/${VERSION}/linux-${ARCH}/resilio-sync_${ARCH}.tar.gz /tmp/sync.tgz
RUN tar -xf /tmp/sync.tgz -C /usr/bin rslsync && rm -f /tmp/sync.tgz

COPY sync.conf.default /etc/
COPY run_sync /usr/bin/

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

ENTRYPOINT ["run_sync"]
CMD ["--config", "/mnt/sync/sync.conf"]
