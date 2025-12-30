FactoryBot.define do
  factory :answer do
    correct { false }
    card { nil }
    quiz_session { nil }
  end
end
