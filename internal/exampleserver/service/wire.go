//go:build wireinject
// +build wireinject

package service

import (
	"github.com/douyu/jupiter-layout/internal/pkg/grpc"
	// "github.com/douyu/jupiter-layout/internal/pkg/mysql"
	// "github.com/douyu/jupiter-layout/internal/pkg/redis"
	"github.com/google/wire"
)

func createMockHelloWorldService() *HelloWorld {
	panic(wire.Build(
		NewHelloWorldService,
		grpc.ProviderSet,
		// mysql.ProviderSet,
		// redis.ProviderSet,
		wire.Struct(new(Options), "*"),
	))
}
