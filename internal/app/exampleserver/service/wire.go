//go:build wireinject
// +build wireinject

package service

import (
	// "github.com/douyu/jupiter-layout/internal/pkg/redis"
	"github.com/google/wire"
)

func createMockHelloWorldService() *HelloWorld {
	panic(wire.Build(
		ProviderSet,
	))
}
