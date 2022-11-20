FROM registry.access.redhat.com/ubi9/ubi:latest

LABEL maintainer="Mark Hahl <mark@hahl.id.au>" \
      org.label-schema.name="Postfix Docker Image" \
      org.label-schema.description="Docker image for Postfix the free and open-source mail transfer agent." \
      org.label-schema.url="https://github.com/mhahl/postfix-container" \
      org.label-schema.vcs-url="https://github.com/mhahl/postfix-container" \
      org.label-schema.schema-version="2.0"

# Update system
RUN dnf upgrade -y && \
    dnf clean all && \
    rm -rf /var/cache/yum

# Install tools
RUN dnf install -y postfix && dnf clean all -y

EXPOSE 25
EXPOSE 587

CMD ["postfix", "-v", "start-fg"]
