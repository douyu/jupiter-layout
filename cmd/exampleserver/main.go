package main

import (
	"github.com/douyu/jupiter-layout/internal/app/exampleserver/server"
)

func main() {
	app, err := server.NewApp()
	if err != nil {
		panic(err)
	}

	_ = app.Run()
}
