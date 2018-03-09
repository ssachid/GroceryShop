class Order < ApplicationRecord
  before_save { self.status = "on its way"}

  # associations
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  # validations
  validates :user_id, presence: true

  def total
    self.products.reduce(0) { |sum, product| sum + (product.price * product.quantity) }
  end

  def self.created_between(start_date, end_date)
    where("created_at >= ? AND created_at <= ?", start_date.to_date, end_date.to_date)
  end
end

