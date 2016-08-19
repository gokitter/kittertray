package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/gokitter/kitter/client"
)

type MeowRequest struct {
	Meow string `json: "meow"`
}

func MeowHandler(rw http.ResponseWriter, r *http.Request) {
	var request MeowRequest
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&request)

	if err != nil || request.Meow == "" || len(request.Meow) > 154 {
		http.Error(rw, "Invalid message length", http.StatusBadRequest)
		return
	}

	kc := clientfactory.Create("0.0.0.0:50051")
	defer kc.Close()

	kc.WriteMessage(request.Meow)
}
