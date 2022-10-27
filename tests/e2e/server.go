package e2e

import (
	"time"

	"github.com/BurntSushi/toml"
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/server"
	"github.com/douyu/jupiter/pkg/conf"
	"github.com/douyu/jupiter/pkg/conf/datasource/file"
)

func startServer() {
	// load config
	conf.LoadFromDataSource(file.NewDataSource("../../config/exampleserver/local-live.toml", false), toml.Unmarshal)

	app := jupiter.DefaultApp()
	server.InitApp(app)
	go app.Run()
	defer app.Stop()

	// wait for server start
	time.Sleep(time.Second)
}
