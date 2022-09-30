package rocketmq

import (
	"context"

	"github.com/douyu/jupiter/pkg/client/rocketmq"
	"github.com/google/wire"
)

var ProviderSet = wire.NewSet(NewInstance)

type Example struct {
	exampleProducer *rocketmq.Producer
}

func NewInstance() ExampleInterface {
	return &Example{
		exampleProducer: rocketmq.StdProducerConfig("example").Build(),
	}
}

func (ins *Example) PushExampleMessage(ctx context.Context) error {
	return ins.exampleProducer.SendWithContext(ctx, []byte("hello world"))
}
