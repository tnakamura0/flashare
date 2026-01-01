FactoryBot.define do
  factory :quiz_session do
    current_question_index { 1 }
    total_questions { 1 }
    status { 1 }
    user { nil }
    deck { nil }
  end
end
