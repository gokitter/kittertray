package handlers

import (
	"encoding/json"
	"net/http"
)

type HealthResponse struct {
	StatusMessage string `json:"status_message"`
}

func HealthHandler(rw http.ResponseWriter, r *http.Request) {
	response := &HealthResponse{"OK"}

	encoder := json.NewEncoder(rw)
	encoder.Encode(&response)
}
