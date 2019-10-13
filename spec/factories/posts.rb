FactoryBot.define do
  factory :post do
    title { "MyText" }
    body { "MyString" }
    user { nil }
  end
end
