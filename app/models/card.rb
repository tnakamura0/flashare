class Card < ApplicationRecord
  validates :name, presence: true, length: { maximum: 10 }
  validates :meaning, presence: true, length: { maximum: 24 }

  belongs_to :user
end
