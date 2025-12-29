class Card < ApplicationRecord
  validates :name, presence: true, length: { maximum: 22 }
  validates :meaning, presence: true, length: { maximum: 44 }

  belongs_to :user
  has_many :decks, through: :deck_cards
  had_many :deck_cards, dependent: :destroy
end
