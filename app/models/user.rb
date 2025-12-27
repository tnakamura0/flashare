class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: true, length: { minimum: 8 }

  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy
end
