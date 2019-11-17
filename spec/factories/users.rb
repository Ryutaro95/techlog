FactoryBot.define do
  factory :user do
    name { "Test User" }
    sequence(:email) { |n| "testuser#{n}@tester.com" }
    password { "password" }
    profile { "プロフィール文を記述する場所です" }
  end
end
