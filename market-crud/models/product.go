package models

// Product is the DB model and JSON payload shape
type Product struct {
	ID          uint    `json:"id" gorm:"primaryKey;autoIncrement"`
	Name        string  `json:"name"`
	Price       float64 `json:"price"`
	Quantity    int     `json:"quantity"`
	Description string  `json:"description"`
}
