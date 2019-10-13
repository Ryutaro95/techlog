require 'rails_helper'

RSpec.describe User, type: :model do

  it "FactoryBotのユーザーが有効な状態であること" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "ユーザ名、メールアドレス、パスワードがあれば有効であること" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "ユーザ名がなければ無効な状態であること" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?

    expect(user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?

    expect(user.errors[:email]).to include("を入力してください")
  end

  it "パスワードがなければ無効な状態であること" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?

    expect(user.errors[:password]).to include("を入力してください")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    FactoryBot.create(:user, email: "test@user.com")
    user = FactoryBot.build(:user, email: "test@user.com")
    user.valid?

    expect(user.errors[:email]).to include("はすでに存在します")
  end


  context "パスワードが8文字のとき" do
    it "有効な状態であること" do
      user = FactoryBot.build(:user, password: "a" * 8)
      expect(user).to be_valid
    end
  end

  context "パスワードが7文字のとき" do
    it "無効な状態であること" do
      user = FactoryBot.build(:user, password: "a" * 7)
      user.valid?
      expect(user.errors[:password]).to include("は8文字以上で入力してください")
    end
  end
end
