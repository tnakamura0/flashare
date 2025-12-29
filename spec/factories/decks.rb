FactoryBot.define do
  factory :deck do
    name { Faker::Name.name }
    description { Faker::Esport.game }
    public { false }
    association :user
  end
end
