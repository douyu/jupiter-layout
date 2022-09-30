package service

import (
	"testing"

	"github.com/BurntSushi/toml"
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter/pkg/conf"
	"github.com/douyu/jupiter/pkg/conf/datasource/file"
	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

func TestMockSuites(t *testing.T) {
	conf.LoadFromDataSource(file.NewDataSource("../../../../config/exampleserver/local-live.toml", false), toml.Unmarshal)

	app := jupiter.DefaultApp()
	go app.Run()

	RegisterFailHandler(Fail)
	RunSpecs(t, "mock test cases")
}
