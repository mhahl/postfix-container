FROM centos:latest

LABEL maintainer="Mark Hahl <mark@hahl.id.au>" \
      org.label-schema.name="Postfix Docker Image" \
      org.label-schema.description="Docker image for Postfix the free and open-source mail transfer agent." \
      org.label-schema.url="https://github.com/wolskie/postfix-container" \
      org.label-schema.vcs-url="https://github.com/wolskie/postfix-container" \
      org.label-schema.schema-version="1.0"

# Update system
RUN dnf install -y epel-release -y && \
    dnf upgrade -y && \
    dnf clean all && \
    rm -rf /var/cache/yum
	
# Install tools
RUN dnf install -y wget supervisor rsyslog postfix && dnf clean all

COPY supervisord.conf /etc/supervisord.conf
COPY rsyslog.conf /etc/rsyslog.conf

EXPOSE 25
EXPOSE 587

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
