package main

import (
	"github.com/douyu/jupiter"
	"github.com/douyu/jupiter-layout/internal/exampleserver/server"
)

func main() {
	app := jupiter.DefaultApp()

	if err := server.InitApp(app); err != nil {
		panic(err)
	}

	app.Run()
}
