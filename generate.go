package main

// 基于go generate自动生成相关代码
// 自动生成interface：https://github.com/jupiter/cmd/jupiter
// 依赖注入：https://github.com/google/wire
// mock代码生成：https://github.com/vektra/mockery

//go:generate bash -c "find . -type f -path '*.go'|grep -v vendor/|egrep -e 'interface_|mock_'|xargs -r rm"
//go:generate jupiter struct2interface -d internal/pkg
//go:generate mockery --all --inpackage --dir internal/pkg
//go:generate wire ./...
