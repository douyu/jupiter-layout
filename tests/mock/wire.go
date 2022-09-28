//go:build wireinject
// +build wireinject

package e2e

import (
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	// "github.com/douyu/jupiter-layout/internal/pkg/redis"
	"github.com/google/wire"
)

func CreateExampleService() *service.HelloWorld {
	panic(wire.Build(
		service.ProviderSet,
	))
}
