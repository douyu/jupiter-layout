package grpc

import (
	"context"

	grpcclient "github.com/douyu/jupiter/pkg/client/grpc"
	"github.com/douyu/jupiter/pkg/xlog"
	helloworldv1 "github.com/douyu/proto/gen/go/api/helloworld/v1"
	"github.com/google/wire"
	"go.uber.org/zap"
	"google.golang.org/grpc"
)

// 本文件负责grpc下面各种ProviderSet的注册
var (
	ProviderSet = wire.NewSet(
		NewExample,
	)
)

type Example struct {
	cc grpc.ClientConnInterface
}

func NewExample() ExampleInterface {
	return &Example{
		cc: grpcclient.StdConfig("example").MustSingleton(),
	}
}

func (s *Example) SayHello(ctx context.Context, req *helloworldv1.SayHelloRequest) (*helloworldv1.SayHelloResponse, error) {

	cc := helloworldv1.NewGreeterServiceClient(s.cc)

	res, err := cc.SayHello(ctx, req)
	if err != nil {
		xlog.L(ctx).Error("sayHello failed", zap.Error(err), zap.Any("res", res), zap.Any("req", req))
		return nil, err
	}

	return res, nil
}
