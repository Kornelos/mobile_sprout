package sprout_functions

import "net/http"

func respondWithError(w http.ResponseWriter, msg string, status int) {
	w.WriteHeader(status)
	w.Write([]byte(msg))
}
