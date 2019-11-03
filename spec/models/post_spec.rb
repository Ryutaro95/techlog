require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it "タイトル、本文、user_id があれば有効な状態であること" do
    post = FactoryBot.create(:post)

    expect(post).to be_valid
  end

  it "タイトルがなければ無効な状態であること" do
    post = FactoryBot.build(:post, title: nil)
    post.valid?

    expect(post.errors[:title]).to include("を入力してください")
  end

  it "本文がなければ無効な状態であること" do
    post = FactoryBot.build(:post, body: nil)
    post.valid?
    
    expect(post.errors[:body]).to include("を入力してください")
  end

  it "user_id がなければ無効な状態であること" do
    post = FactoryBot.build(:post, user: nil)

    expect(post).to_not be_valid
  end

  it "ユーザーが削除されたとき、投稿記事も削除されること" do
    post = FactoryBot.create(:post,
      title: "削除タイトル",
      body: "削除されていますか?",
      user: user
    )

    expect{ user.destroy }.to change{ Post.count }.by(-1)
  end

  describe "記事投稿機能の文字数制限をテストする" do
    context "タイトルが100文字のとき" do
      it "有効な状態であること" do
        post = FactoryBot.build(:post, title: "a" * 100)

        expect(post).to be_valid
      end
    end

    context "タイトルが101文字のとき" do
      it "無効な状態であること" do
        post = FactoryBot.build(:post, title: "a" * 101)
        post.valid?

        expect(post.errors[:title]).to include("は100文字以内で入力してください")
      end
    end

    context "本文が10000文字のとき" do
      it "有効な状態であること" do
        post = FactoryBot.build(:post, body: "a" * 10000)

        expect(post).to be_valid
      end
    end

    context "本文が10001文字のとき" do
      it "無効な状態であること" do
        post = FactoryBot.build(:post, body: "a" * 10001)
        post.valid?

        expect(post.errors[:body]).to include("は10000文字以内で入力してください")
      end
    end
  end
end
