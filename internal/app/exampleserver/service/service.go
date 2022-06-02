package service

import (
	"context"

	commonv1 "github.com/douyu/jupiter-layout/gen/api/go/common/v1"
	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/douyu/jupiter-layout/internal/pkg/grpc"
	"github.com/douyu/jupiter-layout/internal/pkg/mysql"
	"github.com/douyu/jupiter-layout/internal/pkg/redis"
	"github.com/douyu/jupiter/pkg/util/xerror"
	"github.com/google/wire"
)

var ProviderSet = wire.NewSet(
	NewHelloWorldService,
	wire.Struct(new(Options), "*"),
	redis.ProviderSet,
	mysql.ProviderSet,
	grpc.ProviderSet,
)

// Options wireservice
type Options struct {
	ExampleGrpc grpc.ExampleInterface
	// ExampleMysql mysql.ExampleInterface
	// ExampleRedis redis.ExampleInterface
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
	if req.GetName() == "" {
		return nil, xerror.InvalidArgument.WithMsg("name参数错误")
	}

	err := s.ExampleGrpc.SayHello(ctx)
	if err != nil {
		return nil, err
	}

	return &helloworldv1.SayHelloResponse{
		Data: &commonv1.CommonData{
			Message: "hello world",
		},
	}, nil
}
