require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  describe "必須チェック" do
    it "ユーザー名、メール、パスワード、プロフィール文、があれば有効な状態であること" do
      user = FactoryBot.build(:user)

      expect(user).to be_valid
    end

    it "ユーザー名がなければ無効な状態であること" do
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
  end

  describe "重複チェック" do
    it "重複したメールアドレスなら無効な状態であること" do
      FactoryBot.create(:user, email: "test@tester.com")
      user = FactoryBot.build(:user, email: "test@tester.com")

      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end

  describe "文字数制限"  do
    context "ユーザー名が20文字のとき" do
      it "有効な状態であること" do
        user = FactoryBot.build(:user, name: "a" * 20)

        expect(user).to be_valid
      end
    end
    context "ユーザー名が21文字のとき" do
      it "無効な状態であること" do
        user = FactoryBot.build(:user, name: "a" * 21)
        user.valid?

        expect(user.errors[:name]).to include("は20文字以内で入力してください")
      end
    end

    context "メールアドレスが255文字のとき" do
      it "有効な状態であること" do
        user = FactoryBot.build(:user, email: "#{"a" * 246}@test.com")

        expect(user).to be_valid
      end
    end
    context "メールアドレスが256文字のとき" do
      it "無効な状態であること" do
        user = FactoryBot.build(:user, email: "#{"a" * 247}@test.com")
        user.valid?

        expect(user.errors[:email]).to include("は255文字以内で入力してください")
      end
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

    context "プロフィール文が400文字のとき" do
      it "有効な状態であること" do
        user = FactoryBot.build(:user, profile: "a" * 400)

        expect(user).to be_valid
      end
    end
    context "プロフィール文が401文字のとき" do
      it "無効な状態であること" do
        user = FactoryBot.build(:user, profile: "a" * 401)
        user.valid?

        expect(user.errors[:profile]).to include("は400文字以内で入力してください")
      end
    end
  end

  describe "#follow" do
    context "フォローしていない他のユーザーをフォローしたとき" do
      it "フォロー関係が作成される" do
        user = FactoryBot.create(:user, id: 1)
        other_user = FactoryBot.create(:user, id: 2)
        following = user.follow(other_user)

        expect(following.follow_id).to eq 2
      end
    end
    
    context "既にフォロー中のユーザーをフォローしたとき" do
      it "フォロー関係が作成されずidが同じであること" do
        user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        following = user.follow(other_user)
        following2 = user.follow(other_user)

        expect(following2.id).to eq following.id
      end
    end

    context "自分自身をフォローしたとき" do
      it "nilが戻って来ること" do
        user = FactoryBot.create(:user)
        
        expect(user.follow(user)).to eq nil
      end
    end
  end

  describe "#unfollow" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    context "フォローしているとき" do
      it "フォロー関係が削除されnilであること" do
      end
    end
  end

  describe "#following?" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    context "フォローしているとき" do
      it "trueであること" do
        following = user.follow(other_user)

        expect(user.following?(other_user)).to be_truthy
      end
    end

    context "フォローしていないとき" do
      it "falseであること" do
        expect(user.following?(other_user)).to be_falsey
      end
    end
  end
end