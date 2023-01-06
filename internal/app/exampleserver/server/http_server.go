package server

import (
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	"github.com/douyu/jupiter/pkg/server/xecho"
)

type HttpServer struct {
	*xecho.Server
}

func NewHttpServer(svc *service.HelloWorld) *HttpServer {
	s := xecho.StdConfig("http").MustBuild()

	s.GET("/", xecho.GRPCProxyWrapper(svc.SayHello))

	return &HttpServer{
		Server: s,
	}
}
