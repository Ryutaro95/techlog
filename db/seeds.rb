20.times.each do |i|
  User.create!(
    name: "テストユーザー#{i + 1}",
    email: "test.#{i + 1}@user.com",
    profile: "はじめまして、テストユーザー#{i + 1}です。\nよろしくお願いします",
    password: "password"
  )
end

User.create!(
   name: "かんたんユーザー",
   email: "kantan@user.com",
   profile: "かんたんユーザーです。TECHLOGの管理者です。",
   password: "password",
   admin: true
)