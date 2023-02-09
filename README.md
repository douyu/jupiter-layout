[Jupiter](https://github.com/douyu/jupiter) Project Layout
===

[![GoTest](https://github.com/douyu/jupiter-layout/workflows/Go/badge.svg)](https://github.com/douyu/jupiter-layout/actions)
[![codecov](https://codecov.io/gh/douyu/jupiter-layout/branch/main/graph/badge.svg?token=DO7GHMMELG)](https://codecov.io/gh/douyu/jupiter-layout)
[![Go Report Card](https://goreportcard.com/badge/github.com/douyu/jupiter-layout)](https://goreportcard.com/report/github.com/douyu/jupiter-layout)
![license](https://img.shields.io/badge/license-Apache--2.0-green.svg)


Concepts
---

* Support HTTP/gRPC with Protobuf
* Single Repo and Multiple Applications
* High Cohesion and Low Coupling
* Dependency Injection
* Auto Code Generation
* Unit Test with Mock
* E2E Test with Docker
* Define errors in Proto
* Define validate rules in Proto
* Auto generate Swagger API Documentation

Quick Start with Kubernetes
---

* Install Juno and Jupiter-Layout

```bash
kubectl apply -f https://github.com/douyu/juno/releases/download/nightly/install.yml
kubectl apply -f https://github.com/douyu/jupiter-layout/releases/download/latest/install.yml
```

* Wait for ready... Expose Jupiter-Layout Service

```bash
kubectl port-forward deployments/juno-admin 50002:50002 50004:50004 -n default
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

DEVELOPER Guide
---

* [DEVELOPER.md](DEVELOPER.md)

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
