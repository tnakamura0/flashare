FactoryBot.define do
  factory :deck do
    name { "MyString" }
    description { "MyText" }
    public { false }
    user { nil }
  end
end
