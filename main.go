// @title Go Market API
// @version 1.0
// @description This is a market CRUD API.
// @host localhost:8080
// @BasePath /

package main

import (
	"go-market/config"
	"go-market/controllers"
	"go-market/models"

	"github.com/gin-gonic/gin"

	// SWAGGER IMPORTS
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
	_ "go-market/docs" // important: docs folder auto-generated
)

func main() {
	// connect DB and auto migrate Product table
	config.ConnectDB()
	config.DB.AutoMigrate(&models.Product{})

	r := gin.Default()

	// PRODUCT ROUTES
	r.GET("/products", controllers.GetProducts)
	r.GET("/products/:id", controllers.GetProduct)
	r.POST("/products", controllers.CreateProduct)
	r.PUT("/products/:id", controllers.UpdateProduct)
	r.DELETE("/products/:id", controllers.DeleteProduct)

	// SWAGGER ROUTE
	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	// start server on port 8080
	r.Run(":8080")
}
