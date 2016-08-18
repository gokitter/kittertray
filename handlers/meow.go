package handlers

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/gokitter/kitter/client"
	"github.com/gokitter/kitter/kitter"
	"google.golang.org/grpc"
)

type MeowRequest struct {
	Meow string `json: "meow"`
}

func MeowHandler(rw http.ResponseWriter, r *http.Request) {
	var request MeowRequest
	decoder := json.NewDecoder(r.Body)
	decoder.Decode(&request)

	conn, err := grpc.Dial("localhost:50051", grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()

	c := kitter.NewKitterClient(conn)
	client.WriteMessage(c, request.Meow)
}
