FROM alpine:3.15.3

WORKDIR /workspace

RUN apk update \
  && apk add bash \
  && apk add openssh-client \
  && apk add rsync \
  && apk add tar  \
  && apk add xz  \
  && apk add git \
  && rm -rf /var/cache/apk/* \
  && mkdir -p ~/.ssh \
  && chmod 700 ~/.ssh \
  && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

COPY ./docker/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
