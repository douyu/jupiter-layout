package server

import (
	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/douyu/jupiter-layout/internal/exampleserver/service"
	"github.com/douyu/jupiter/pkg/server/xgrpc"
)

// var GrpcProviderSet = wire.NewSet(NewGrpcServer)

type GrpcServer struct {
	*xgrpc.Server
	Helloworld *service.HelloWorld
}

func NewGrpcServer(opts *service.HelloWorld) *GrpcServer {
	return &GrpcServer{
		Server:     xgrpc.StdConfig("grpc").MustBuild(),
		Helloworld: opts,
	}
}

func (s *GrpcServer) Mux() {
	helloworldv1.RegisterGreeterServiceServer(s.Server.Server, s.Helloworld)
}
