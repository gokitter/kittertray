package main

import (
	"fmt"
	"net/http"

	"github.com/gokitter/kitter/server"
	"github.com/gokitter/kittertray/handlers"
)

func main() {
	startRPC()
	startHTTP()
}

func startHTTP() {
	//http.HandleFunc("/v1/health", handlers.HealthHandler)
	http.HandleFunc("/v1/meow", handlers.MeowHandler)

	fmt.Println("Listening for connections on port", 8001)
	http.ListenAndServe(fmt.Sprintf(":%v", 8001), nil)
}

func startRPC() {
	go server.StartRPCServer("0.0.0.0:50051")
}
