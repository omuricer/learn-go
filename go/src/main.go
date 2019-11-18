package main

import (
	"fmt"
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

type Letter struct {
	ID			int		`json:id`
	Title		string	`json:title`
	Author		string	`json:author`
	PostDate	string	`json:yaar`
}

var letters []Letter

// Controller for the / route (home)
func homePage(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "This is the home page. Welcome!")
}

func getLetters(w http.ResponseWriter, r *http.Request) {
	// log.Printf("Get all letters.")
	json.NewEncoder(w).Encode(letters)
}

func getLetter(w http.ResponseWriter, r *http.Request) {
	log.Printf("Get a letter.")

	params := mux.Vars(r)
	i, _ := strconv.Atoi(params["id"])

	for _, letter := range letters {
		if letter.ID == i {
			json.NewEncoder(w).Encode(letter)
		}
	}
}

func addLetter(w http.ResponseWriter, r *http.Request) {
	log.Printf("Add a letter.")

	var letter Letter

	json.NewDecoder(r.Body).Decode(&letter)

	letters = append(letters, letter)
	json.NewEncoder(w).Encode(letters)
}

func updateArticle(w http.ResponseWriter, r *http.Request) {
	log.Printf("Update a article.")
}

func removeArticle(w http.ResponseWriter, r *http.Request) {
	log.Printf("Remove a article.")
}

func handleRequests() {
    router := mux.NewRouter().StrictSlash(true)
    router.HandleFunc("/", homePage).Methods("GET")
	router.HandleFunc("/letter", getLetters).Methods("GET")
	router.HandleFunc("/letter/{id}", getLetter).Methods("GET")
	router.HandleFunc("/letter", addLetter).Methods("PUT")
	log.Fatal(http.ListenAndServe(":8080", router))
}

func main() {
	letters = append(letters, 
		Letter{ID: 1,	Title: "test1",		Author: "auth1",	PostDate: "2019/01/01"},
		Letter{ID: 2,	Title: "test2",		Author: "auth2",	PostDate: "2019/01/02"},
		Letter{ID: 3,	Title: "test3",		Author: "auth3",	PostDate: "2019/01/03"},
		Letter{ID: 4,	Title: "test4",		Author: "auth4",	PostDate: "2019/01/04"},
	)

	handleRequests()
	
}