package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"go-market/config"
	"go-market/models"
)

// GetProducts -> GET /products
func GetProducts(c *gin.Context) {
	var products []models.Product
	config.DB.Find(&products)             // fetch all records
	c.JSON(http.StatusOK, products)      // return 200 + JSON
}
// GetProducts godoc
// @Summary Get all products
// @Description Get list of products
// @Tags products
// @Produce json
// @Success 200 {array} models.Product
// @Router /products [get]

// GetProduct -> GET /products/:id
func GetProduct(c *gin.Context) {
	id := c.Param("id")
	var product models.Product
	if err := config.DB.First(&product, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Product not found"})
		return
	}
	c.JSON(http.StatusOK, product)
}
// CreateProduct godoc
// @Summary Create product
// @Tags products
// @Accept json
// @Produce json
// @Param product body models.Product true "Product"
// @Success 201 {object} models.Product
// @Router /products [post]
// CreateProduct -> POST /products
func CreateProduct(c *gin.Context) {
	var product models.Product
	if err := c.ShouldBindJSON(&product); err != nil {   // bind and validate JSON
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	config.DB.Create(&product)                          // insert
	c.JSON(http.StatusCreated, product)                 // 201 created
}

// UpdateProduct -> PUT /products/:id
func UpdateProduct(c *gin.Context) {
	id := c.Param("id")
	var product models.Product
	if err := config.DB.First(&product, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Product not found"})
		return
	}
	var input models.Product
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	// update fields
	product.Name = input.Name
	product.Price = input.Price
	product.Quantity = input.Quantity
	product.Description = input.Description
	config.DB.Save(&product)
	c.JSON(http.StatusOK, product)
}

// DeleteProduct -> DELETE /products/:id
func DeleteProduct(c *gin.Context) {
	id := c.Param("id")
	if err := config.DB.Delete(&models.Product{}, id).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Delete failed"})
		return
	}
	c.Status(http.StatusNoContent) // 204 No Content
}
