class Card < ApplicationRecord
  validates :name, presence: true, length: { maximum: 18 }
  validates :meaning, presence: true, length: { maximum: 54 }

  belongs_to :user
  has_many :deck_cards, dependent: :destroy
  has_many :decks, through: :deck_cards
  has_many :answers, dependent: :destroy
end
