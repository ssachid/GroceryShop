class Product < ApplicationRecord
  # associations
  has_many :order_products
  has_many :orders, through: :order_products

  has_many :category_products
  has_many :categories, through: :category_products

  # validations
  validates :name, presence: true,
                   length: { minimum: 3, maximum: 25}
  validates :quantity, presence: true
  validates :price, presence: true
end
