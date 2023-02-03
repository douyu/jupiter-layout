package server

import (
	helloworldv1 "github.com/douyu/jupiter-layout/api/helloworld/v1"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	"github.com/douyu/jupiter/pkg/server/xecho"
)

type HttpServer struct {
	*xecho.Server
}

func NewHttpServer(svc *service.HelloWorld) *HttpServer {
	s := xecho.StdConfig("http").MustBuild()

	helloworldv1.RegisterGreeterServiceEchoServer(s.Echo, svc)

	return &HttpServer{
		Server: s,
	}
}
