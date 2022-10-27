package redis

import (
	"context"

	"github.com/douyu/jupiter/pkg/client/redis"
	"github.com/google/wire"
)

// 本文件负责redis下面各种ProviderSet的注册
var ProviderSet = wire.NewSet(
	NewExample,
)

type Example struct {
	cc *redis.Client
}

func NewExample() ExampleInterface {
	return &Example{
		cc: redis.StdConfig("example").MustSingleton(),
	}
}

func (s *Example) Info(ctx context.Context) (string, error) {
	return s.cc.CmdOnMaster().Info(ctx).Result()
}
