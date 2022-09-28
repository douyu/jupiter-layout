package service

import (
	"context"

	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/douyu/jupiter-layout/internal/pkg/grpc"
	"github.com/douyu/jupiter-layout/internal/pkg/mysql"

	// "github.com/douyu/jupiter-layout/internal/pkg/redis"
	"github.com/douyu/jupiter-layout/internal/pkg/resty"
	"github.com/douyu/jupiter/pkg/util/xerror"
	"github.com/douyu/jupiter/pkg/xlog"
	"github.com/google/wire"
	"go.uber.org/zap"
)

var ProviderSet = wire.NewSet(
	NewHelloWorldService,
	wire.Struct(new(Options), "*"),
	// redis.ProviderSet,
	mysql.ProviderSet,
	grpc.ProviderSet,
	resty.ProviderSet,
)

// Options wireservice
type Options struct {
	ExampleGrpc  grpc.ExampleInterface
	ExampleMysql mysql.ExampleInterface
	// ExampleRedis redis.ExampleInterface
	ExampleResty resty.ExampleInterface
}

type HelloWorld struct {
	Options
}

// NewHelloWorldService
func NewHelloWorldService(options Options) *HelloWorld {
	return &HelloWorld{
		Options: options,
	}
}

func (s *HelloWorld) SayHello(ctx context.Context, req *helloworldv1.SayHelloRequest) (*helloworldv1.SayHelloResponse, error) {
	xlog.L(ctx).Info("SayHello started", zap.String("name", req.GetName()))

	if req.GetName() == "" {
		return nil, xerror.InvalidArgument.WithMsg("name参数错误")
	}

	err := s.ExampleMysql.Migrate(ctx)
	if err != nil {
		return nil, err
	}

	resp := new(helloworldv1.SayHelloResponse)
	if req.Name != "done" {
		resp, err := s.ExampleGrpc.SayHello(ctx, &helloworldv1.SayHelloRequest{
			Name: "done",
		})
		if err != nil {
			xlog.L(ctx).Error("sayHello failed", zap.Error(err), zap.Any("res", resp), zap.Any("req", req))
			return nil, err
		}

		_, err = s.ExampleResty.SayHello(ctx)
		if err != nil {
			return nil, err
		}

	}

	return resp, nil
}
