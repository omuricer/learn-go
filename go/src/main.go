package main

import (
	// "database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"time"
	// "mime/multipart"
	"os"
	"io"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/mux"
	"github.com/gorilla/schema"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
)

type Letter struct {
	ID            int       `json:"id"`
	From          string    `json:"from"`
	FromMail      string    `json:"fromMail"`
	File          string    `json:"file"`
	InnerFilePath string    `json:"InnerFilePath"`
	DecryptKey    string    `json:"decryptKey"`
	Expire        time.Time `json:"expire" gorm:"default:null"`
	ExpiredAt     time.Time `json:"expireAt" gorm:"default:null"`
	IsDeleted     string    `json:"isDeleted"`
	CreatedAt     time.Time `json:"createdAt"`
	UpdatedAt     time.Time `json:"updatesAt"`
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

	params := mux.Vars(r)
	letterId, _ := strconv.Atoi(params["id"])

	db, err := gorm.Open("mysql", "letter:letter@tcp(db:3306)/letter?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatal("db err!!")
	}
	db.LogMode(true)
	defer db.Close()

	var letter Letter
	db.First(&letter, letterId)

	fmt.Println(letter)
	json.NewEncoder(w).Encode(letter)
}

func addLetter(w http.ResponseWriter, r *http.Request) {
	log.Printf("Add a letter.")

	var letter Letter

	json.NewDecoder(r.Body).Decode(&letter)

	letters = append(letters, letter)
	json.NewEncoder(w).Encode(letters)
}

var decoder = schema.NewDecoder()

type PostLetter struct {
	From     string
	FromMail string
	File     string
}

func postLetter(w http.ResponseWriter, r *http.Request) {

	if r.Header.Get("Content-Type") != "application/json" {
		w.WriteHeader(http.StatusUnsupportedMediaType)
		return
	}

	// err := r.ParseForm()
	// if err != nil {
	// 	// Handle error
	// }
	// fmt.Println(r.PostForm)

	// var postLetter PostLetter
	// err = decoder.Decode(&postLetter, r.PostForm)
	// if err != nil {
	// 	// Handle err
	// }
	// fmt.Println(r.Form.Get("from"))

	var postLetter PostLetter
	err := json.NewDecoder(r.Body).Decode(&postLetter)
	if err != nil {
		panic(err)
	}
	fmt.Println(postLetter)
	defer r.Body.Close()

	// TODO: バリデーションを実装する

	// TODO: DB接続の処理を共通化する
	db, err := gorm.Open("mysql", "letter:letter@tcp(db:3306)/letter?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatal("db err")
	}
	db.LogMode(true)
	defer db.Close()

	// 時間データのサンプル。あとから使うのでとっておく
	// str := "2020/01/01 10:00:00"
	// layout := "2006/01/02 15:03:05"
	// t, _ := time.Parse(layout, str)
	letter := Letter{
		From: postLetter.From,
		FromMail : postLetter.FromMail,
		File: postLetter.File,
	}

	db.Create(&letter)
	json.NewEncoder(w).Encode(letter)

}

func postFile(w http.ResponseWriter, r *http.Request) {

	uploadFile, uploadFileHeader, err := r.FormFile("file")
	if err != nil {
		// upload error
	}

	file, err := os.Create("./" + uploadFileHeader.Filename)
	if err != nil {
		// file create error
	}

	size, err := io.Copy(file, uploadFile)
	if err != nil {
		// file write error
	}

	fmt.Println(size)
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

	router.HandleFunc("/letter", postLetter).Methods("POST")
	router.HandleFunc("/file", postFile).Methods("POST")

	log.Fatal(http.ListenAndServe(":8080", router))
}

func main() {
	// letters = append(letters,
	// 	Letter{ID: 1, Title: "test1", Author: "auth1", PostDate: "2019/01/01"},
	// 	Letter{ID: 2, Title: "test2", Author: "auth2", PostDate: "2019/01/02"},
	// 	Letter{ID: 3, Title: "test3", Author: "auth3", PostDate: "2019/01/03"},
	// 	Letter{ID: 4, Title: "test4", Author: "auth4", PostDate: "2019/01/04"},
	// )

	handleRequests()

}
