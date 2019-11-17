require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "必須チェック" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }
    context "コメント、post_id、user_idがあるとき" do
      it "有効な状態であること" do
        expect(FactoryBot.build(:comment, user: other_user, post: post)).to be_valid
      end
    end

    context "コメントがないとき" do
      it "無効な状態であること" do
        comment = FactoryBot.build(:comment, comment: nil, user: other_user, post: post)
        comment.valid?

        expect(comment.errors[:comment]).to include("を入力してください")
      end
    end

    context "post_idがないとき" do
      it "無効な状態であること" do
        comment = FactoryBot.build(:comment, user: other_user, post: nil)

        expect(comment).to_not be_valid
      end
    end

    context "user_idがないとき" do
      it "無効な状態であること" do
        comment = FactoryBot.build(:comment, user: nil, post: post)

        expect(comment).to_not be_valid
      end
    end
  end

  describe "文字数制限" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }
    context "コメント文字数が2000文字のとき" do
      it "有効な状態であること" do
        comment = FactoryBot.build(:comment, comment: "a" * 2000, user: other_user, post: post)

        expect(comment).to be_valid
      end
    end

    context "コメント文字数が2001文字のとき" do
      it "無効な状態であること" do
        comment = FactoryBot.build(:comment, comment: "a" * 2001, user: other_user, post: post)
        comment.valid?

        expect(comment.errors[:comment]).to include("は2000文字以内で入力してください")
      end
    end
  end

  describe "アソシエーションテスト" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }

    context "ブログ記事が削除されたとき" do
      it "コメントも削除されること" do
        FactoryBot.create(:comment, user: other_user, post: post)

        expect{ post.destroy }.to change{ Comment.count }.by(-1)
      end
    end

    context "ユーザーが削除されたとき" do
      it "コメントも削除されること" do
        FactoryBot.create(:comment, user: other_user, post: post)

        expect{ other_user.destroy }.to change{ Comment.count }.by(-1)
      end
    end
  end
end
