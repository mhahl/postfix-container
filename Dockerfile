FROM alpine:latest

RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        ca-certificates \
 && update-ca-certificates \
 
 # Install postfix
 && apk add --no-cache \
    postfix postfix-pcre rsyslog cyrus-sasl cyrus-sasl-plain cyrus-sasl-login tzdata supervisor \
 && (rm "/tmp/"* 2>/dev/null || true) && (rm -rf /var/cache/apk/* 2>/dev/null || true)

COPY supervisord.conf /etc/supervisord.conf
COPY rsyslog.conf /etc/rsyslog.conf

EXPOSE 25
EXPOSE 587

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
