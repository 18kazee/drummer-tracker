FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
    profile { 'MyText' }
    role { 'admin' }
    guest { false }
  end

  trait :activated do
    after(:create, &:activate!)
  end
end
