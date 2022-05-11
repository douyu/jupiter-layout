package redis

import (
	"github.com/douyu/jupiter/pkg/client/redis"

	"github.com/google/wire"
)

// 本文件负责redis下面各种ProviderSet的注册
var ProviderSet = wire.NewSet(
	NewExample,
)

type ExampleInterface interface {
}

type Example struct {
	cc *redis.Redis
}

func NewExample() ExampleInterface {
	return &Example{
		cc: redis.StdRedisConfig("example").Build(),
	}
}
