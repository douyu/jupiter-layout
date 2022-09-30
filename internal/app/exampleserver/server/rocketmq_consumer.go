package server

import (
	"context"

	"github.com/apache/rocketmq-client-go/v2/primitive"
	"github.com/douyu/jupiter/pkg/client/rocketmq"
	"github.com/douyu/jupiter/pkg/xlog"
	"go.uber.org/zap"
)

type RocketMQ struct {
	exampleConsumer *rocketmq.PushConsumer
}

func NewRocketMQ() *RocketMQ {
	return &RocketMQ{
		exampleConsumer: rocketmq.StdPushConsumerConfig("example").Build(),
	}
}

func (ins *RocketMQ) Register() error {
	ins.exampleConsumer.RegisterSingleMessage(func(ctx context.Context, me *primitive.MessageExt) error {
		xlog.L(ctx).Info("message received", zap.Any("data", me))

		return nil
	})
	return nil
}
