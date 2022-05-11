package grpc

import (
	grpcclient "github.com/douyu/jupiter/pkg/client/grpc"
	"github.com/google/wire"
	"google.golang.org/grpc"
)

// 本文件负责grpc下面各种ProviderSet的注册
var (
	ProviderSet = wire.NewSet(
		NewExample,
	)
)

type ExampleInterface interface {
}

type Example struct {
	cc grpc.ClientConnInterface
}

func NewExample() ExampleInterface {
	return &Example{
		cc: grpcclient.StdConfig("example").Build(),
	}
}
