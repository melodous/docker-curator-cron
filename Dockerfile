FROM alpine:latest
MAINTAINER Raúl Melo <raul.melo@opensolutions.cloud>

RUN apk update && apk add dcron wget rsync ca-certificates && rm -rf /var/cache/apk/*

RUN apk --update add python py-setuptools py-pip dcron wget rsync ca-certificates && \
    pip install elasticsearch-curator==5.1.1 && \
    apk del py-pip && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /var/log/cron && mkdir -m 0644 -p /var/spool/cron/crontabs && touch /var/log/cron/cron.log && mkdir -m 0644 -p /etc/cron.d

COPY /scripts/* /

ENTRYPOINT ["/docker-entry.sh"]
CMD ["/docker-cmd.sh"]
