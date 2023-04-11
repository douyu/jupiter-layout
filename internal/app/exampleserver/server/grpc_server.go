package server

import (
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	"github.com/douyu/jupiter/pkg/server/xgrpc"
	helloworldv1 "github.com/douyu/proto/gen/go/api/helloworld/v1"
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
