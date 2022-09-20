package rocketmq

import (
	"github.com/douyu/jupiter/pkg/client/rocketmq"
)

type Instance struct {
	pushConsumer *rocketmq.PushConsumer
}

func NewInstance() *Instance {
	return &Instance{
		pushConsumer: rocketmq.StdPushConsumerConfig("example").Build(),
	}
}
