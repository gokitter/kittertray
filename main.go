package main

import (
	"fmt"
	"net/http"

	"github.com/gokitter/kittertray/handlers"
)

func main() {
	startHTTP()
}

func startHTTP() {
	http.HandleFunc("/v1/health", handlers.HealthHandler)

	fmt.Println("Listening for connections on port", 8001)
	http.ListenAndServe(fmt.Sprintf(":%v", 8001), nil)
}
