FROM alpine:latest

LABEL maintainer="Mark Hahl <mark@hahl.id.au>" \
      org.label-schema.name="Postfix Docke Image" \
      org.label-schema.description="Docker image for Postfix the free and open-source mail transfer agent." \
      org.label-schema.url="https://github.com/wolskie/postfix-container" \
      org.label-schema.vcs-url="https://github.com/wolskie/postfix-container" \
      org.label-schema.schema-version="2.0"

RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        ca-certificates \
 && update-ca-certificates \
 
 # Install postfix
 && apk add --no-cache \
    postfix postfix-pcre cyrus-sasl cyrus-sasl-login tzdata \
 && (rm "/tmp/"* 2>/dev/null || true) && (rm -rf /var/cache/apk/* 2>/dev/null || true)

EXPOSE 25
EXPOSE 587

USER 1001

CMD ["/usr/sbin/postfix", "-c", "/etc/postfix start"]

