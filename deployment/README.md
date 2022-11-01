# Deployment

## 一键启动

```bash
docker-compose -f deployment/docker-compose.yml up -d
```

## 访问

访问 [http://localhost:50002](http://localhost:50002)

使用如下账号进行登录

```txt
username: admin
password: admin
```

## 相关组件

* etcd[localhost:2379](localhost:2379)
* redis[localhost:6379](localhost:6379)
* mysql[localhost:3306](localhost:3306)
* clickhouse[localhost:9000](localhost:9000)
* grafana[localhost:3000](localhost:3000)
* prometheus[localhost:9090](localhost:9090)
* rocketmq[localhost:9876](localhost:9876)
* juno-admin[localhost:50002](localhost:50002)
* juno-agent[localhost:50010](localhost:50010)
* jaeger[localhost:14268](localhost:14268)
* otel-collector[localhost:4317](localhost:4317)
* uptrace[localhost:14318](localhost:14318)
