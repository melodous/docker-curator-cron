FROM alpine:latest
MAINTAINER Raúl Melo <raul.melo@opensolutions.cloud>

COPY requirements.txt /
RUN apk update && apk add dcron wget rsync ca-certificates

RUN apk --update add python py-setuptools py-pip dcron wget rsync ca-certificates && \
    pip install -r /requirements.txt && \
    apk del py-pip && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /var/log/cron && mkdir -m 0644 -p /var/spool/cron/crontabs && touch /var/log/cron/cron.log && mkdir -m 0644 -p /etc/cron.d

COPY /scripts/* /

ENTRYPOINT ["/docker-entry.sh"]
CMD ["/docker-cmd.sh"]
