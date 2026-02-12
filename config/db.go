package config

import (
	"log"
	"github.com/glebarez/sqlite"
	"gorm.io/gorm"
)

var DB *gorm.DB

// ConnectDB opens a sqlite connection and assigns to DB
func ConnectDB() {
	database, err := gorm.Open(sqlite.Open("market.db"), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect database:", err)
	}
	DB = database
}
