require 'rails_helper'

RSpec.describe UserFollowRelation, type: :model do
  describe "必須チェック" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    context "user_idとfollow_idがあるとき" do
      it "有効な状態であること" do
        following = user.user_follow_relations.create(follow_id: other_user.id)

        expect(following).to be_valid
      end
    end

    context "user_idがないとき" do
      it "無効な状態であること" do
        following = user.user_follow_relations.create(follow_id: other_user.id)
        following.user_id = nil

        expect(following).to_not be_valid
      end
    end

    context "follow_idがないとき" do
      it "無効な状態であること" do
        following = user.user_follow_relations.create(follow_id: other_user.id)
        following.follow_id = nil

        expect(following).to_not be_valid
      end
    end
  end

  describe "アソシエーションテスト" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    context "フォローされた側のユーザーが削除されたとき" do
      it "フォロー関係も削除されること" do
        following = user.user_follow_relations.create(follow_id: other_user.id)

        expect{ other_user.destroy }.to change{ UserFollowRelation.count }.by(-1)
      end
    end

    context "フォローした側のユーザーが削除されたとき" do
      it "フォロー関係が削除されること" do
        following = user.user_follow_relations.create(follow_id: other_user.id)

        expect{ user.destroy }.to change{ UserFollowRelation.count }.by(-1)
      end
    end
  end
end
