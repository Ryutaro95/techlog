FactoryBot.define do
  factory :user do
    name { "TestUser" }
    sequence(:email) { |n| "test#{n}@user.com" }
    password { "password" }
  end
end
