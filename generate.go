package main

// 基于go generate自动生成相关代码
// proto代码生成：https://github.com/bufbuild/buf
// 依赖注入：https://github.com/google/wire
// mock代码生成：https://github.com/vektra/mockery

//go:generate buf generate --path api
//go:generate wire ./...
//go:generate mockery --all --inpackage --dir internal/pkg
