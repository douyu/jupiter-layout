package server

import (
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/controller"
	"github.com/douyu/jupiter/pkg/governor"
	"github.com/google/wire"
)

var ProviderSet = wire.NewSet(
	wire.Struct(new(controller.Options), "*"),
	NewGrpcServer,
	NewHttpServer,
	NewRocketMQ,
)

type Options struct {
	http     *HttpServer
	grpc     *GrpcServer
	rocketmq *RocketMQ
}

func initApp(app *jupiter.Application, opts Options) error {

	// governor
	if err := app.Serve(governor.StdConfig("govern").Build()); err != nil {
		return err
	}

	// http
	if err := app.Serve(opts.http); err != nil {
		return err
	}

	// grpc
	if err := app.Serve(opts.grpc); err != nil {
		return err
	}

	// rocketmq
	if err := opts.rocketmq.Register(); err != nil {
		return err
	}

	return nil
}
