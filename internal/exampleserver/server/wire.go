//go:build wireinject
// +build wireinject

package server

import (
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter-layout/internal/exampleserver/controller"
	"github.com/douyu/jupiter-layout/internal/exampleserver/service"
	"github.com/google/wire"
)

func InitApp(app *jupiter.Application) error {
	panic(wire.Build(
		wire.Struct(new(Options), "*"),
		controller.ProviderSet,
		service.ProviderSet,
		ProviderSet,
		initApp,
	))
}
