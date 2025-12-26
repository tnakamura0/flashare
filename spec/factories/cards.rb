FactoryBot.define do
  factory :card do
    name { Faker::Esport.player }
    meaning { Faker::Esport.game }
    association :user
  end
end
