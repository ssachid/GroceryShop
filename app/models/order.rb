class Order < ApplicationRecord
  # associations
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  # validations
  validates :user_id, presence: true
  validates :status, presence: true
end
