package server

import (
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	"github.com/douyu/jupiter/pkg/server/xecho"
	"github.com/douyu/proto/api"
	helloworldv1 "github.com/douyu/proto/gen/go/api/helloworld/v1"
	"github.com/labstack/echo/v4"
	httpSwagger "github.com/swaggo/http-swagger/v2"
)

type HttpServer struct {
	*xecho.Server
}

func NewHttpServer(svc *service.HelloWorld) *HttpServer {
	s := xecho.StdConfig("http").MustBuild()

	helloworldv1.RegisterGreeterServiceEchoServer(s.Echo, svc)

	s.GET("/doc.swagger.json", echo.WrapHandler(api.OpenAPIHandler()))
	s.GET("/swagger/*", echo.WrapHandler(httpSwagger.Handler(httpSwagger.URL("/doc.swagger.json"))))

	return &HttpServer{
		Server: s,
	}
}
