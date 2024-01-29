FROM alpine:3.19.1

WORKDIR /workspace

RUN set -e; \
  apk add --no-cache \
    bash \
    coreutils \
    curl \
    git \
    openssh-client \
    pv \
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
