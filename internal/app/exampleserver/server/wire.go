//go:build wireinject
// +build wireinject

package server

import (
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	"github.com/google/wire"
)

func NewApp() (*App, error) {
	panic(wire.Build(
		jupiter.DefaultApp,
		wire.Struct(new(Options), "*"),
		service.ProviderSet,
		ProviderSet,
		newApp,
	))
}
