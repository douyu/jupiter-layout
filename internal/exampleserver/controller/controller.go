package controller

import (
	"github.com/google/wire"
)

var ProviderSet = wire.NewSet(NewHelloWorldHTTPController)

type Options struct {
	HelloWorldHTTP *HelloWorldHTTP
}
