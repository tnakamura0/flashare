class QuizSession < ApplicationRecord
  belongs_to :user
  belongs_to :deck
  has_many :answers, dependent: :destroy
end
