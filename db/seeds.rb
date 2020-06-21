20.times.each do |i|
  User.create!(
    name: "テストユーザー#{i + 1}",
    email: "test.#{i + 1}@user.com",
    profile: "はじめまして、テストユーザー#{i + 1}です。\nよろしくお願いします",
    password: "password"
  )
end