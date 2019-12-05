require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user)}
  let(:post) { FactoryBot.create(:post, user: other_user) }

  describe "必須チェック" do

    context "user_idとpost_idがあるとき" do
      it "いいねが作成されていること" do
        expect{ post.post_like(user) }.to change{ Like.count }.by(1)
      end
    end

    context "user_idがないとき" do
      it "いいねが作成されないこと" do
        post.likes.create(user_id: nil)

        expect(Like.count).to eq 0
      end
    end

    context "post_idがないとき" do
      it "いいねが作成されないこと" do
        Like.create(user: user)

        expect(Like.count).to eq 0
      end
    end
  end

  describe "関連データの削除チェック" do
    context "いいねしたユーザーが削除されたとき" do
      it "いいねも削除されること" do
        post.post_like(user)
        expect{ user.destroy }.to change{ Like.count }.by(-1)
      end
    end

    context "いいねした投稿が削除されたとき" do
      it "いいねも削除されること" do
        post.post_like(user)
        expect{ post.destroy }.to change{ Like.count }.by(-1)
      end
    end
  end

end
