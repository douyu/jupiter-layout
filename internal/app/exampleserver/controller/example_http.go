package controller

import (
	"errors"
	"net/http"

	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	"github.com/douyu/jupiter/pkg/util/xerror"
	"github.com/douyu/jupiter/pkg/xlog"
	echo "github.com/labstack/echo/v4"
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

type SayHelloRequest struct {
	Name string `query:"name"`
}

type SayHelloRequestJSON struct {
	Name string `json:"name"`
}

type SayHelloRequestForm struct {
	Name string `form:"name"`
}

func (s *HelloWorldHTTP) SayHello(c echo.Context) error {
	req := new(SayHelloRequest)
	err := c.Bind(req)
	if err != nil {
		return err
	}

	jsonReq := new(SayHelloRequestJSON)
	err = c.Bind(jsonReq)
	if err != nil {
		return err
	}

	if jsonReq.Name != "" {
		xlog.L(c.Request().Context()).Error("should not pass", zap.Any("req", jsonReq))
		return errors.New("invalid request")
	}

	formReq := new(SayHelloRequestForm)
	err = c.Bind(formReq)
	if err != nil {
		return err
	}

	if formReq.Name != "" {
		xlog.L(c.Request().Context()).Error("should not pass", zap.Any("req", formReq))
		return errors.New("invalid request")
	}

	res, err := s.helloworld.SayHello(c.Request().Context(), &helloworldv1.SayHelloRequest{
		Name: req.Name,
	})
	if err != nil {
		xlog.L(c.Request().Context()).Error("sayHello failed", zap.Error(err), zap.Any("res", res), zap.Any("req", req))
		return c.JSON(http.StatusOK, err)
	}

	return c.JSON(http.StatusOK, xerror.OK.WithData(res))
}
