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

    expect(user.errors[:name]).to include("can't be blank")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?

    expect(user.errors[:email]).to include("can't be blank")
  end

  it "パスワードがなければ無効な状態であること" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?

    expect(user.errors[:password]).to include("can't be blank")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    FactoryBot.create(:user, email: "test@user.com")
    user = FactoryBot.build(:user, email: "test@user.com")
    user.valid?

    expect(user.errors[:email]).to include("has already been taken")
  end


  context "パスワードが6文字のとき" do
    it "有効な状態であること" do
      user = FactoryBot.build(:user, password: "a" * 6)
      expect(user).to be_valid
    end
  end

  context "パスワードが5文字のとき" do
    it "無効な状態であること" do
      user = FactoryBot.build(:user, password: "a" * 5)
      expect(user).to_not be_valid
    end
  end

  context "パスワードが20文字のとき" do
    it "有効な状態であること" do
      user = FactoryBot.build(:user, password: "a" * 20)
      expect(user).to be_valid
    end
  end

  context "パスワードが21文字のとき" do
    it "無効な状態であること" do
      user = FactoryBot.build(:user, password: "a" * 21)
      expect(user).to_not be_valid
    end
  end
end
