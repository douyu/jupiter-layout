FROM golang:1.16 AS builder

COPY . /src
WORKDIR /src

# prepare for build
RUN go env -w GO111MODULE=on &&\
    go env -w GOPROXY=https://goproxy.cn,direct &&\
    GOPROXY=https://goproxy.cn

# build
RUN mkdir -p bin/ &&\
    go build -o ./bin/ ./cmd/...

# copy compiled file to minimize image
FROM debian:stable-slim

COPY --from=builder /src/bin /
WORKDIR /

EXPOSE 9527
EXPOSE 9528

VOLUME /config

CMD ["./exampleserver","--config","/config/local-live.toml"]
