FROM golang:1.18 AS builder

# COPY . /src
WORKDIR /src

RUN go env -w GO111MODULE=on &&\
    go env -w GOPROXY=https://goproxy.cn,direct &&\
    GOPROXY=https://goproxy.cn

RUN go install github.com/douyu/jupiter/cmd/jupiter@v0.6.5

EXPOSE 9527
EXPOSE 9528

ENTRYPOINT ["/go/bin/jupiter", "run" , "-c", "./cmd/exampleserver/.jupiter.toml"]