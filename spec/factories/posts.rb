FactoryBot.define do
  factory :post do
    user
    drummer
    room
    tweet { "MyText" }
  end
end
