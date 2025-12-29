class Deck < ApplicationRecord
  # 最大文字数は仮で指定
  # 後でデザインとの兼ね合いで決める
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 100 }
  validates :public, inclusion: [ true, false ]

  belongs_to :user
  has_many :deck_cards, dependent: :destroy
  has_many :cards, through: :deck_cards
end
