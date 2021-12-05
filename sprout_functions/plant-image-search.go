package sprout_functions

import (
	"bytes"
	"encoding/json"
	"errors"
	"io"
	"mime/multipart"
	"net/http"
	"net/url"
	"os"
)

// PostPlantInfo is an HTTP Cloud Function
func PostPlantInfo(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodPost:
		break
	default:
		respondWithError(w, "405 - Method Not Allowed", http.StatusMethodNotAllowed)
		return
	}

	speciesData, err := getPlantNameFromImageApi(r.Body)
	if err != nil {
		respondWithError(w, "Plant not found: "+err.Error(), http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	err = json.NewEncoder(w).Encode(speciesData)
	if err != nil {
		respondWithError(w, "Error encoding JSON to response body", http.StatusInternalServerError)
		return
	}
}

func getPlantNameFromImageApi(body io.Reader) (*SpeciesData, error) {
	apiKey := os.Getenv("IMAGE_SEARCH_API_KEY")
	var b bytes.Buffer
	w := multipart.NewWriter(&b)
	fw, err := w.CreateFormFile("images", "plant.jpeg")
	if err != nil {
		return nil, err
	}
	_, err = io.Copy(fw, body)
	if err != nil {
		return nil, err
	}
	err = w.WriteField("organs", "leaf") //todo: support other organ types
	if err != nil {
		return nil, err
	}
	w.Close()

	resp, err := http.Post("https://my-api.plantnet.org/v2/identify/all?include-related-images=false&lang=en&api-key="+url.QueryEscape(apiKey), w.FormDataContentType(), &b)
	if err != nil {
		return nil, err
	}
	var responseData = PlantNameResponseData{}
	err = json.NewDecoder(resp.Body).Decode(&responseData)
	if err != nil {
		return nil, err
	}
	if len(responseData.Results) < 1 {
		return nil, errors.New("response body is empty: " + resp.Status)

	}
	return &responseData.Results[0].Species, nil
}

type PostPlantInfoRequest struct {
	Image string `json:"image"`
}

type PlantNameResponseData struct {
	Results []PlantNameApiResult `json:"results"`
}

type PlantNameApiResult struct {
	Score   float32     `json:"score"`
	Species SpeciesData `json:"species"`
}

type SpeciesData struct {
	ScientificName string   `json:"scientificNameWithoutAuthor"`
	CommonNames    []string `json:"commonNames"`
}
