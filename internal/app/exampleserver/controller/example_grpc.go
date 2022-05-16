package controller

import (
	"context"

	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/service"
	"github.com/douyu/jupiter/pkg/util/xerror"
	"github.com/douyu/jupiter/pkg/xlog"
	"go.uber.org/zap"
)

type HelloWorldGRPC struct {
	helloworld *service.HelloWorld
}

func NewHelloWorldGRPCController(helloworld *service.HelloWorld) *HelloWorldGRPC {
	return &HelloWorldGRPC{
		helloworld: helloworld,
	}
}

func (s *HelloWorldGRPC) SayHello(ctx context.Context, req *helloworldv1.SayHelloRequest) (*helloworldv1.SayHelloResponse, error) {

	res, err := s.helloworld.SayHello(ctx, req)
	if err != nil {
		xlog.Error("sayHello failed", zap.Error(err), zap.Any("res", res), zap.Any("req", req))
		return &helloworldv1.SayHelloResponse{
			Error: uint32(xerror.Convert(err).GetEcode()),
			Msg:   xerror.Convert(err).GetMsg(),
		}, nil
	}

	return res, nil
}
