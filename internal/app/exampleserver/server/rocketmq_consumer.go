package server

import (
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	"github.com/douyu/jupiter/pkg/client/rocketmq"
)

type RocketMQ struct {
	exampleConsumer *rocketmq.PushConsumer

	exampleServerService *service.HelloWorld
}

func NewRocketMQ() *RocketMQ {
	return &RocketMQ{
		exampleConsumer: rocketmq.StdPushConsumerConfig("example").Build(),
	}
}

func (ins *RocketMQ) Register() error {
	ins.exampleConsumer.RegisterSingleMessage(ins.exampleServerService.ProcessConsumer)
	_ = ins.exampleConsumer.Start()

	return nil
}
