class User < ApplicationRecord
  # before callbacks
  before_save { self.email = email.downcase }

  # associations
  has_many :orders, dependent: :destroy
  has_many :products, through: :orders

  # validations
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false},
                       length: { minimum: 3, maximum: 15 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 100 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
  has_secure_password
end
