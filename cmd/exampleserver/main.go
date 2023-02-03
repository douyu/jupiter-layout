package main

import (
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/server"
	"github.com/samber/lo"
)

func main() {
	app := jupiter.DefaultApp()
	lo.Must0(server.InitApp(jupiter.DefaultApp()))

	_ = app.Run()
}
