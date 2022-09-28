// Code generated by Wire. DO NOT EDIT.

//go:generate go run github.com/google/wire/cmd/wire
//go:build !wireinject
// +build !wireinject

package service

import (
	"github.com/douyu/jupiter-layout/internal/pkg/grpc"
	"github.com/douyu/jupiter-layout/internal/pkg/mysql"
	"github.com/douyu/jupiter-layout/internal/pkg/resty"
)

// Injectors from wire.go:

func createMockHelloWorldService() *HelloWorld {
	exampleInterface := grpc.NewExample()
	mysqlExampleInterface := mysql.NewExample()
	restyExampleInterface := resty.NewExample()
	options := Options{
		ExampleGrpc:  exampleInterface,
		ExampleMysql: mysqlExampleInterface,
		ExampleResty: restyExampleInterface,
	}
	helloWorld := NewHelloWorldService(options)
	return helloWorld
}
