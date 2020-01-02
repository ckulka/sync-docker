ARG FROM_ARCH=amd64

FROM alpine AS builder

ARG VERSION=2.6.4
ARG ARCH=x64
ADD https://download-cdn.resilio.com/${VERSION}/linux-${ARCH}/resilio-sync_${ARCH}.tar.gz resilio-sync.tar.gz
RUN tar zxvf resilio-sync.tar.gz


FROM ${FROM_ARCH}/ubuntu:18.04

ARG VERSION=2.6.4

LABEL Resilio Inc. <support@resilio.com>
LABEL com.resilio.version="${VERSION}"

COPY --from=builder rslsync /usr/bin
COPY sync.conf.default /etc/
COPY run_sync /usr/bin/

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

ENTRYPOINT ["run_sync"]
CMD ["--config", "/mnt/sync/sync.conf"]
