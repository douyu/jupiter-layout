[Jupiter](https://github.com/douyu/jupiter) 项目模板
===

[![GoTest](https://github.com/douyu/jupiter-layout/workflows/Go/badge.svg)](https://github.com/douyu/jupiter-layout/actions)
[![codecov](https://codecov.io/gh/douyu/jupiter-layout/branch/main/graph/badge.svg?token=DO7GHMMELG)](https://codecov.io/gh/douyu/jupiter-layout)
[![Go Report Card](https://goreportcard.com/badge/github.com/douyu/jupiter-layout)](https://goreportcard.com/report/github.com/douyu/jupiter-layout)
![license](https://img.shields.io/badge/license-Apache--2.0-green.svg)

概念
---

* 单仓库多应用
* 依赖注入
* 自动代码生成
* 单元测试
* 高内聚低耦合

安装依赖
---

```bash
go install -v github.com/douyu/jupiter/cmd/jupiter@latest
```

初始化
---

```bash
jupiter new testproject-go
cd testproject-go
go mod tidy -v
```

启动依赖中间件
---

```bash
docker-compose -f deployment/docker-compose.yml up -d
```

生成依赖代码
---

```bash
make init
make generate
```

运行项目
---

* 通过 Makefile 启动 exampleserver

```bash
make run
```

* 启动，并监听文件变更自动重新构建

```bash
jupiter run -c cmd/exampleserver/.jupiter.toml
```

* 通过 docker-compose 启动服务，并监听文件变更自动重新构建

```bash
docker-compose up
```

* 仅启动

```bash
go run ./cmd/exampleserver --config config/exampleserver/local-live.toml
```

测试接口
---

* HTTP

```bash
curl "localhost:9527?name=bob"
```

```json
{"error":0,"msg":"请求正常","data":{"message":"hello wolrd"}}
```

* GRPC

```bash
grpcurl -import-path api -proto api/helloworld/v1/helloworld.proto -plaintext -d '{"name":"bob"}' localhost:9528  helloworld.v1.GreeterService/SayHello
```

```json
{
  "data": {
    "message": "hello world"
  }
}
```

Jaeger Admin
---

open [http://localhost:16686/search](http://localhost:16686/search) to checkout opentelemtry trace data.

![Jaeger](https://raw.githubusercontent.com/hnlq715/imgs-all-in-one/main/obsidian/%E6%88%AA%E5%B1%8F2022-09-30%2018.31.27.png)

Bugs and Feedback
---

For bug report, questions and discussions please submit an issue.

Contributing
---

Contributions are always welcomed!

You can start with the issues labeled with good first issue.

<a href="https://github.com/douyu/jupiter-layout/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=douyu/jupiter-layout" />
</a>

Contact
---

* [Wechat Group](https://jupiter.douyu.com/join/#%E5%BE%AE%E4%BF%A1)
