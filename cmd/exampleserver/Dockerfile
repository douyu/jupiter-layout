FROM alpine:latest

WORKDIR /app

COPY exampleserver /app/bin/exampleserver
COPY config /app/config

EXPOSE 9527
EXPOSE 9528
EXPOSE 9529

ENTRYPOINT ["/app/bin/exampleserver", "--config", "config/exampleserver/local-live.toml"]
