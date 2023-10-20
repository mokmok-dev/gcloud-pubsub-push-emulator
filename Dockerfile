# syntax=docker/dockerfile:1.3
FROM curlimages/curl:latest as fetcher

ARG WAITFOR_VERSION=2.2.4
RUN curl -vsSLo /tmp/wait-for "https://github.com/eficode/wait-for/releases/download/v${WAITFOR_VERSION}/wait-for"
RUN chmod +x /tmp/wait-for

FROM google/cloud-sdk:451.0.1

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY --from=fetcher /tmp/wait-for /usr/bin
COPY pubsub.py /usr/bin/pubsub
COPY run.sh /run.sh

EXPOSE 8681 8682/udp

ENTRYPOINT ["./run.sh"]
