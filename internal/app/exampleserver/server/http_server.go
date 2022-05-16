package server

import (
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/controller"
	"github.com/douyu/jupiter/pkg/server/xecho"
	echo "github.com/labstack/echo/v4"
)

type HttpServer struct {
	*xecho.Server
	controller.Options
}

func NewHttpServer(opts controller.Options) *HttpServer {
	s := xecho.StdConfig("http").MustBuild()

	s.GET("/", func(c echo.Context) error {
		return opts.HelloWorldHTTP.SayHello(c)
	})

	return &HttpServer{
		Server: s,
	}
}
