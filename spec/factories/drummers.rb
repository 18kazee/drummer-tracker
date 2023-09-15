FactoryBot.define do
  factory :drummer do
    name { Faker::Name.name }
    country { [0, 1].sample }
  end
end
