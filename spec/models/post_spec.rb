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

  describe "いいね機能" do
    
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    # post_like(user)
    context "ユーザーが他のユーザーの投稿にいいねしたとき" do
      it "いいね数が1になっていること" do
        post = FactoryBot.create(:post, user: other_user)
        post.post_like(user)

        expect(post.likes_count).to eq 1
      end
    end

    # post_unlike(user)
    context "ユーザーが他のユーザー投稿のいいねを解除したとき" do
      it "いいね数が0になっていること" do
        post = FactoryBot.create(:post, user: other_user)
        post.post_like(user)
        post.post_unlike(user)

        expect(post.likes_count).to eq 0
      end
    end

    # like?(user)
    context "投稿にいいねされているとき" do
      it "trueであること" do
        post = FactoryBot.create(:post, user: other_user)
        post.post_like(user)

        expect(post.like?(user)).to be_truthy
      end
    end

    context "投稿にいいねされていないとき" do
      it "falseであること" do
        post = FactoryBot.create(:post, user: other_user)

        expect(post.like?(user)).to be_falsey
      end
    end
  end

  describe "ストック機能のメソッド動作チェック" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: other_user)}

    # stock(user)
    context "ユーザーが記事をストックしたとき" do
      it "ストックが追加されていること" do

        expect{ post.stock(user) }.to change{ Stock.count }.by(1)
      end
    end

    # unstock(user)
    context "ユーザーが記事のストックを解除したとき" do
      it "ストックが削除されていること" do
        post.stock(user)

        expect{ post.unstock(user) }.to change{ Stock.count }.by(-1)
      end
    end

    # stocked?(user)
    context "既に記事をストックしているとき" do
      it "trueであること" do
        post.stock(user)

        expect(post.stocked?(user)).to be_truthy
      end
    end

    context "記事をストックしていないとき" do
      it "falseであること" do
        expect(post.stocked?(user)).to be_falsey
      end
    end
  end

end
