FROM alpine:latest

LABEL maintainer="Mark Hahl <mhahl@emesis.io>" \
      org.label-schema.name="Postfix Docke Image" \
      org.label-schema.description="Docker image for Postfix the free and open-source mail transfer agent." \
      org.label-schema.url="https://github.com/wolskie/postfix-container" \
      org.label-schema.vcs-url="https://github.com/wolskie/postfix-container" \
      org.label-schema.schema-version="1.0"

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
