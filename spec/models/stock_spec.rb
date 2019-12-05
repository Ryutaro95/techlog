require 'rails_helper'

RSpec.describe Stock, type: :model do

  describe "必須チェック" do

    context "user_idとpost_idがあるとき" do
      it "記事がストックされること作成されていること" do
        # expect{ post.post_like(user) }.to change{ Like.count }.by(1)
      end
    end

    context "user_idがないとき" do
      it "記事がストックされないこと" do
        # post.likes.create(user_id: nil)

        # expect(Like.count).to eq 0
      end
    end

    context "post_idがないとき" do
      it "記事がストックされないこと" do
        # Like.create(user: user)

        # expect(Like.count).to eq 0
      end
    end
  end
end
