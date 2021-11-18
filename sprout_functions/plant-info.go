package sprout_functions

import (
	"cloud.google.com/go/firestore"
	"context"
	"encoding/json"
	"errors"
	"log"
	"net/http"
	"net/url"
	"os"
	"strings"
)

// GetPlantInfo is an HTTP Cloud Function
func GetPlantInfo(w http.ResponseWriter, r *http.Request) {
	plantNames, exists := r.URL.Query()["name"]
	if !exists && len(plantNames) < 1 {
		respondWithError(w, "Query param name is missing", http.StatusBadRequest)
		return
	}

	plantInfo, err := getPlant(strings.Title(plantNames[0]))
	if err != nil {
		respondWithError(w, "Plant not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	err = json.NewEncoder(w).Encode(plantInfo)
	if err != nil {
		respondWithError(w, "Error encoding JSON to response body", http.StatusInternalServerError)
		return
	}
}

func getPlant(plantName string) (*PlantInfo, error) {
	ctx := context.Background()
	dbClient := createClient(ctx)

	plantInfo, err := getPlantFromDb(ctx, dbClient, plantName)
	if err != nil {
		log.Printf("Fetching plant from db failed: %s", err)
		plantInfo, err = getPlantFromApi(plantName)
		if err != nil {
			log.Printf("Getting plant from API failed: %s ", err)
			return nil, err
		}
		go savePlantToDb(ctx, dbClient, plantInfo)
	}
	return plantInfo, nil
}

// PlantInfo is a cloud function final response
type PlantInfo struct {
	PlantType       string `json:"type"`
	Name            string `json:"name"`
	BinomialName    string `json:"binomial_name"`
	Description     string `json:"description"`
	SunRequirements string `json:"sun_requirements"`
	SowingMethod    string `json:"sowing_method"`
	MainImagePath   string `json:"main_image_path"`
}

func FromApiResponse(info *ApiPlantInfo) *PlantInfo {
	return &PlantInfo{
		Name:            info.Attributes.Name,
		PlantType:       info.PlantType,
		BinomialName:    info.Attributes.BinomialName,
		Description:     info.Attributes.Description,
		SunRequirements: info.Attributes.SunRequirements,
		SowingMethod:    info.Attributes.SowingMethod,
		MainImagePath:   info.Attributes.MainImagePath,
	}
}

// db functions
func createClient(ctx context.Context) *firestore.Client {
	projectID := os.Getenv("GCP_PROJECT")

	client, err := firestore.NewClient(ctx, projectID)
	if err != nil {
		log.Fatalf("Failed to create client: %v", err)
	}
	return client
}

func savePlantToDb(ctx context.Context, client *firestore.Client, info *PlantInfo) {
	_, _, err := client.Collection("plant-info").Add(ctx, info)
	if err != nil {
		log.Printf("Failed saving plant info: %s", err)
	}
	defer client.Close()
}

func getPlantFromDb(ctx context.Context, client *firestore.Client, plantName string) (*PlantInfo, error) {
	documentSnapshot, err := client.Collection("plant-info").Where("Name", "==", plantName).Documents(ctx).Next()
	if err != nil {
		log.Printf("Failed executing query for plant info (item may not exist): %s", err)
		return nil, err
	}
	plantInfo := PlantInfo{}
	err = documentSnapshot.DataTo(&plantInfo)
	if err != nil {
		log.Printf("Failed parsing db plant info: %s", err)
		return nil, err
	}
	defer client.Close()
	return &plantInfo, nil
}

// api functions

func getPlantFromApi(plantName string) (*PlantInfo, error) {
	resp, err := http.Get("https://openfarm.cc/api/v1/crops/?filter=" + url.QueryEscape(plantName))
	if err != nil {
		return nil, err
	}
	var responseData = ResponseData{}
	err = json.NewDecoder(resp.Body).Decode(&responseData)
	if err != nil {
		return nil, err
	}
	if len(responseData.Data) < 1 {
		return nil, errors.New("response body is empty")

	}
	return FromApiResponse(&responseData.Data[0]), nil
}

type ResponseData struct {
	Data []ApiPlantInfo `json:"data"`
}

type ApiPlantInfo struct {
	PlantType  string     `json:"type"`
	Attributes Attributes `json:"attributes"`
}

type Attributes struct {
	Name            string `json:"name"`
	BinomialName    string `json:"binomial_name"`
	Description     string `json:"description"`
	SunRequirements string `json:"sun_requirements"`
	SowingMethod    string `json:"sowing_method"`
	MainImagePath   string `json:"main_image_path"`
}

func respondWithError(w http.ResponseWriter, msg string, status int) {
	w.WriteHeader(status)
	w.Write([]byte(msg))
}
