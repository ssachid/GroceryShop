class Category < ApplicationRecord
  # associations
  has_many :category_products
  has_many :products, through: :category_products

  # validations
  validates :title, presence: true,
                    uniqueness: true,
                    length: { minimum: 3, maximum: 25}
end
