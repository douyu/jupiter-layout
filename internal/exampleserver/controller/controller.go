package controller

import (
	"github.com/google/wire"
)

var ProviderSet = wire.NewSet(
	NewHelloWorldHTTPController,
	NewHelloWorldGRPCController,
)

type Options struct {
	HelloWorldHTTP *HelloWorldHTTP
	HelloWorldGRPC *HelloWorldGRPC
}
