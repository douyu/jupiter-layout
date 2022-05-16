package server

import (
	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/controller"
	"github.com/douyu/jupiter/pkg/server/xgrpc"
)

// var GrpcProviderSet = wire.NewSet(NewGrpcServer)

type GrpcServer struct {
	*xgrpc.Server
	controller.Options
}

func NewGrpcServer(opts controller.Options) *GrpcServer {

	s := xgrpc.StdConfig("grpc").MustBuild()
	helloworldv1.RegisterGreeterServiceServer(s.Server, opts.HelloWorldGRPC)

	return &GrpcServer{
		Server: s,
	}
}
