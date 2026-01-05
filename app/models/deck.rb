class Deck < ApplicationRecord
  validates :name, presence: true, length: { maximum: 36 }
  validates :description, length: { maximum: 72 }
  validates :public, inclusion: [ true, false ]

  belongs_to :user
  has_many :deck_cards, dependent: :destroy
  has_many :cards, through: :deck_cards
  has_many :quiz_sessions, dependent: :destroy
end
