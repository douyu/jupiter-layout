package server

import "github.com/douyu/jupiter/pkg/server/governor"

func NewGovernServer() *governor.Server {
	return governor.StdConfig("govern").Build()
}
