DEVELOPER
===

Installation
---

```bash
go install -v github.com/douyu/jupiter/cmd/jupiter@latest
```

Initialize Project
---

```bash
jupiter new testproject-go
cd testproject-go
go mod tidy -v
```

Launch Juno Platform
---

```bash
kubectl apply -f https://github.com/douyu/juno/releases/download/latest/install.yml
```

Generation
---

```bash
make init
make generate
```

Running
---

* Run exampleserver through Makefile

```bash
make run
```

* Run and watch file changes to rebuild

```bash
jupiter run -c cmd/exampleserver/.jupiter.toml
```

* Run and watch file changes to rebuild through docker-compose

```bash
docker-compose up
```

* Run only

```bash
go run ./cmd/exampleserver --config config/exampleserver/local-live.toml
```

Test
---

* HTTP

```bash
curl "http://localhost:9527/v1/helloworld.Greeter/SayHello/bob"
```

```json
{"error":0,"msg":"","data":{"name":"hello bob","ageNumber":0,"sex":0,"metadata":null}}
```

* GRPC

```bash
buf curl --schema api --protocol grpc --http2-prior-knowledge --data '{"name":"bob"}' http://localhost:9528/helloworld.v1.GreeterService/SayHello
```

```json
{"data":{"name":"hello bob"}}
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
