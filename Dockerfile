FROM alpine:3.17.3

WORKDIR /workspace

RUN set -e; \
  apk apk add --no-cache \
    bash \
    coreutils \
    curl \
    git \
    openssh-client \
    rsync \
    tar \
    tini \
    xz ; \
  mkdir -p ~/.ssh ; \
  chmod 700 ~/.ssh ; \
  echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

COPY ./docker/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/sbin/tini", "--", "/entrypoint.sh"]
