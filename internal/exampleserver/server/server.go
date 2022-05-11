package server

import (
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter-layout/internal/exampleserver/controller"
	"github.com/google/wire"
)

var ProviderSet = wire.NewSet(
	wire.Struct(new(controller.Options), "*"),
	NewGrpcServer,
	NewHttpServer,
)

type Options struct {
	http *HttpServer
	grpc *GrpcServer
}

func initApp(app *jupiter.Application, opts Options) error {
	// http
	app.Serve(
		opts.http,
	)

	// grpc
	app.Serve(
		opts.grpc,
	)

	return nil
}
