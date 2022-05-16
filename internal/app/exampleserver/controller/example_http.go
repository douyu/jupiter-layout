package controller

import (
	"net/http"

	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	"github.com/douyu/jupiter/pkg/util/xerror"
	"github.com/douyu/jupiter/pkg/xlog"
	"github.com/labstack/echo/v4"
	"go.uber.org/zap"
)

type HelloWorldHTTP struct {
	helloworld *service.HelloWorld
}

func NewHelloWorldHTTPController(helloworld *service.HelloWorld) *HelloWorldHTTP {
	return &HelloWorldHTTP{
		helloworld: helloworld,
	}
}

func (s *HelloWorldHTTP) SayHello(c echo.Context) error {
	name := c.QueryParam("name")

	req := &helloworldv1.SayHelloRequest{
		Name: name,
	}

	res, err := s.helloworld.SayHello(c.Request().Context(), req)
	if err != nil {
		xlog.Error("sayHello failed", zap.Error(err), zap.Any("res", res), zap.Any("req", req))
		return c.JSON(http.StatusOK, err)
	}

	return c.JSON(http.StatusOK, xerror.OK.WithData(res))
}
