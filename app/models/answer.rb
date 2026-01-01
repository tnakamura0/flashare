class Answer < ApplicationRecord
  belongs_to :card
  belongs_to :quiz_session
end
