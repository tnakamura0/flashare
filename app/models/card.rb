class Card < ApplicationRecord
  validates :name, presence: true, length: { maximum: 22 }
  validates :meaning, presence: true, length: { maximum: 44 }

  belongs_to :user
end
