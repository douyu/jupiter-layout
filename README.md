Jupiter 项目模板
===

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
go install -v github.com/google/wire/cmd/wire@latest
go install -v github.com/vektra/mockery/v2@latest
go install -v github.com/bufbuild/buf/cmd/buf@latest
```

初始化
---

```bash
git clone https://github.com/douyu/jupiter-layout
cd jupiter-layout
```

运行项目
---

```
$ go run ./cmd/exampleserver --config config/exampleserver-local-live.toml

2022/05/11 15:57:51 read config: config/exampleserver-local-live.toml
2022/05/11 15:57:51 load config successfully
2022/05/11 15:57:51 hook config, init loggers
2022/05/11 15:57:51 reload default logger with configKey: jupiter.logger.default
2022/05/11 15:57:51 reload default logger with configKey: jupiter.logger.jupiter
2022/05/11 15:57:51 hook config, init runtime(governor)
2022/05/11 15:57:51 hook config, init registry
2022/05/11 15:57:51 hook config, read registry config failed: jupiter.registry: invalid key, maybe not exist in config
2022/05/11 15:57:51 hook config, init sentinel rules
2022/05/11 15:57:51 load config from datasource[config/exampleserver-local-live.toml] completely!

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

```s
$ curl "localhost:9527?name=bob"

{"error":0,"msg":"请求正常","data":{"message":"hello wolrd"}}
```

校验protobuf
---

```bash
$ buf lint --path api
```

校验golang
---

```bash
$ golangci-lint run
```