require 'rails_helper'

RSpec.describe PostTagRelation, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user)} 

  describe "関連したカラムの削除" do
    context "記事が削除されたとき" do
      it "中間テーブルのデータも削除されること" do
        post.save_tags( ["rspec"] )

        expect{ post.destroy }.to change{ PostTagRelation.count }.by(-1)
      end
    end
  end

  describe "一意制約のチェック" do
    let!(:tag_create) { post.tags.create(name: "TestTag") }
    context "一つの記事に別の複数タグが登録されたとき" do
      it "有効な状態であること" do
        tag_post = post.tags.create(name: "OtherTag")

        expect(tag_post).to be_valid
      end
    end

    context "一つの記事に同じタグが登録されたとき" do
      it "無効な状態であること" do
        duplicate_tag_post = post.tags.create(name: "TestTag")

        expect(duplicate_tag_post).to be_invalid
      end

      it "バリデーションエラーメッセージが表示されること" do
        duplicate_tag_post = post.tags.create(name: "TestTag")
        duplicate_tag_post.valid?

        expect(duplicate_tag_post.errors[:name]).to include("はすでに存在します")
      end
    end
  end
end
