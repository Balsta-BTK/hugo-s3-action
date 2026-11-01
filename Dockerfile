FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends bash ca-certificates curl git jq libstdc++6 && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
