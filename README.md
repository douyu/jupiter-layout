[Jupiter](https://github.com/douyu/jupiter) 项目模板
===
[![GoTest](https://github.com/douyu/jupiter-layout/workflows/Go/badge.svg)](https://github.com/douyu/jupiter-layout/actions)
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
go install -v github.com/google/wire/cmd/wire@latest
go install -v github.com/vektra/mockery/v2@latest
go install -v github.com/bufbuild/buf/cmd/buf@latest
go install -v github.com/onsi/ginkgo/v2/ginkgo@latest
go install -v github.com/hnlq715/struct2interface/cmd/struct2interface@latest
go install -v github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
```

初始化
---

```bash
jupiter new testproject-go
cd testproject-go
go mod tidy -v
```

生成依赖代码
---

```bash
go generate
```

```
struct2interface: internal/pkg/grpc: wrote internal/pkg/grpc/interface_Example.go
wire: github.com/douyu/jupiter-layout/internal/exampleserver/service: wrote /home/liqi/workspace/jupiter-layout/internal/exampleserver/service/wire_gen.go
wire: github.com/douyu/jupiter-layout/internal/exampleserver/server: wrote /home/liqi/workspace/jupiter-layout/internal/exampleserver/server/wire_gen.go
wire: github.com/douyu/jupiter-layout/tests/e2e: wrote /home/liqi/workspace/jupiter-layout/tests/e2e/wire_gen.go
12 May 22 11:40 CST INF Starting mockery dry-run=false version=v2.10.4
12 May 22 11:40 CST INF Walking dry-run=false version=v2.10.4
12 May 22 11:40 CST INF Generating mock dry-run=false interface=ExampleInterface qualified-name=github.com/douyu/jupiter-layout/internal/pkg/grpc version=v2.10.4
12 May 22 11:40 CST INF Generating mock dry-run=false interface=ExampleInterface qualified-name=github.com/douyu/jupiter-layout/internal/pkg/mysql version=v2.10.4
12 May 22 11:40 CST INF Generating mock dry-run=false interface=ExampleInterface qualified-name=github.com/douyu/jupiter-layout/internal/pkg/redis version=v2.10.4
```

运行项目
---

* 启动，并监听文件变更自动重新构建

```bash
jupiter run -c cmd/exampleserver/.jupiter.toml
```

* 仅启动

```bash
go run ./cmd/exampleserver --config config/exampleserver/local-live.toml
```

```
2022/05/11 15:57:51 read config: config/exampleserver/local-live.toml
2022/05/11 15:57:51 load config successfully
2022/05/11 15:57:51 hook config, init loggers
2022/05/11 15:57:51 reload default logger with configKey: jupiter.logger.default
2022/05/11 15:57:51 reload default logger with configKey: jupiter.logger.jupiter
2022/05/11 15:57:51 hook config, init runtime(governor)
2022/05/11 15:57:51 hook config, init registry
2022/05/11 15:57:51 hook config, read registry config failed: jupiter.registry: invalid key, maybe not exist in config
2022/05/11 15:57:51 hook config, init sentinel rules
2022/05/11 15:57:51 load config from datasource[config/exampleserver/local-live.toml] completely!

   (_)_   _ _ __ (_) |_ ___ _ __
   | | | | | '_ \| | __/ _ \ '__|
   | | |_| | |_) | | ||  __/ |
  _/ |\__,_| .__/|_|\__\___|_|
 |__/      |_|

 Welcome to jupiter, starting application ...

1652255874      INFO    init listen signal                      {"mod": "app", "event": "init"}
⇨ http server started on 127.0.0.1:9527
1652255875      INFO    start server                            {"mod": "app", "event": "init", "name": "exampleserver", "addr": "grpc://127.0.0.1:9528", "scheme": "grpc"}
1652255875      INFO    start server                            {"mod": "app", "event": "init", "name": "exampleserver", "addr": "http://127.0.0.1:9527", "scheme": "http"}
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

## Bugs and Feedback

For bug report, questions and discussions please submit an issue.

## Contributing

Contributions are always welcomed!

You can start with the issues labeled with good first issue.

<a href="https://github.com/douyu/jupiter-layout/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=douyu/jupiter-layout" />
</a>

## Contact

- [Wechat Group](https://jupiter.douyu.com/join/#%E5%BE%AE%E4%BF%A1)