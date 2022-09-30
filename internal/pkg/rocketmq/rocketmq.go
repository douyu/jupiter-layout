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
	example := rocketmq.StdProducerConfig("example").Build()
	err := example.Start()
	if err != nil {
		panic(err)
	}

	return &Example{
		exampleProducer: example,
	}
}

func (ins *Example) PushExampleMessage(ctx context.Context) error {
	return ins.exampleProducer.SendWithContext(ctx, []byte("hello world"))
}
