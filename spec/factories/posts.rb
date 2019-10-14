FactoryBot.define do
  factory :post do
    title { "ブログタイトルです" }
    body { "ブログ記事本文です" }
    user { FactoryBot.create(:user) }
  end
end
