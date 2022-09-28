package server

import (
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/controller"
	"github.com/douyu/jupiter/pkg/registry/etcdv3"
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
	if err := app.Serve(opts.http); err != nil {
		return err
	}

	// grpc
	if err := app.Serve(opts.grpc); err != nil {
		return err
	}

	app.SetRegistry(etcdv3.StdConfig("etcdv3").MustBuild())

	return nil
}
