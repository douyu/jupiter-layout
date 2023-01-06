package server

import (
	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	"github.com/douyu/jupiter/pkg/server/xgrpc"
)

// var GrpcProviderSet = wire.NewSet(NewGrpcServer)

type GrpcServer struct {
	*xgrpc.Server
}

func NewGrpcServer(svc *service.HelloWorld) *GrpcServer {

	s := xgrpc.StdConfig("grpc").MustBuild()
	helloworldv1.RegisterGreeterServiceServer(s.Server, svc)

	return &GrpcServer{
		Server: s,
	}
}
