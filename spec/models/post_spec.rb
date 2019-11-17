require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "必須チェック" do
    let(:user) { FactoryBot.create(:user) }

    context "タイトル、本文、user_idがあるとき" do
      it "有効な状態であること" do
        expect(FactoryBot.build(:post, user: user)).to be_valid
      end
    end

    context "タイトルがないとき" do
      it "無効な状態であること" do
        post = FactoryBot.build(:post, title: nil, user: user)
        post.valid?

        expect(post.errors[:title]).to include("を入力してください")
      end
    end

    context "本文がないとき" do
      it "無効な状態であること" do
        post = FactoryBot.build(:post, body: nil, user: user)
        post.valid?

        expect(post.errors[:body]).to include("を入力してください")
      end
    end

    context "user_idがないとき" do
      it "無効な状態である" do
        post = FactoryBot.build(:post, user: nil)

        expect(post).to_not be_valid
      end
    end
  end

  describe "文字数制限" do
    let(:user) { FactoryBot.create(:user) }

    context "タイトルが100文字のとき" do
      it "有効な状態であること" do
        post = FactoryBot.build(:post, title: "a" * 100, user: user)

        expect(post).to be_valid
      end
    end

    context "タイトルが101文字のとき" do
      it "無効な状態であること" do
        post = FactoryBot.build(:post, title: "a" * 101, user: user)
        post.valid?

        expect(post.errors[:title]).to include("は100文字以内で入力してください")
      end
    end

    context "本文が10000文字のとき" do
      it "有効な状態であること" do
        post = FactoryBot.build(:post, body: "a" * 10000, user: user)

        expect(post).to be_valid
      end
    end

    context "本文が10001文字のとき" do
      it "無効な状態であること" do
        post = FactoryBot.build(:post, body: "a" * 10001, user: user)
        post.valid?

        expect(post.errors[:body]).to include("は10000文字以内で入力してください")
      end
    end
  end

  context "ユーザーが削除されたとき" do
    it "ブログ記事も削除されること" do
      user = FactoryBot.create(:user)
      FactoryBot.create(:post, user: user)

      expect{ user.destroy }.to change{ Post.count }.by(-1)
    end
  end

end
