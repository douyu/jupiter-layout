package server

import (
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/controller"
	"github.com/douyu/jupiter/pkg/server/governor"
	"github.com/google/wire"
)

var ProviderSet = wire.NewSet(
	wire.Struct(new(controller.Options), "*"),
	NewGrpcServer,
	NewHttpServer,
	NewGovernServer,
	NewRocketMQ,
)

type Options struct {
	http     *HttpServer
	grpc     *GrpcServer
	govern   *governor.Server
	rocketmq *RocketMQ
}

func newApp(opts Options) (*jupiter.Application, error) {
	app := jupiter.DefaultApp()

	// governor
	if err := app.Serve(opts.govern); err != nil {
		return nil, err
	}

	// http
	if err := app.Serve(opts.http); err != nil {
		return nil, err
	}

	// grpc
	if err := app.Serve(opts.grpc); err != nil {
		return nil, err
	}

	// rocketmq
	if err := opts.rocketmq.Register(); err != nil {
		return nil, err
	}

	return app, nil
}
