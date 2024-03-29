package server

import (
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter/pkg/server/governor"
	"github.com/google/wire"
)

var ProviderSet = wire.NewSet(
	NewGrpcServer,
	NewHttpServer,
	NewGovernServer,
	NewRocketMQ,
)

type Options struct {
	app      *jupiter.Application
	http     *HttpServer
	grpc     *GrpcServer
	govern   *governor.Server
	rocketmq *RocketMQ
}

func initApp(opts Options) error {

	// governor
	if err := opts.app.Serve(opts.govern); err != nil {
		return err
	}

	// http
	if err := opts.app.Serve(opts.http); err != nil {
		return err
	}

	// grpc
	if err := opts.app.Serve(opts.grpc); err != nil {
		return err
	}

	// rocketmq
	if err := opts.rocketmq.Register(); err != nil {
		return err
	}

	return nil
}
