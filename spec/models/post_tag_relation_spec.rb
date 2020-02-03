require 'rails_helper'

RSpec.describe PostTagRelation, type: :model do
  describe "関連したカラムの削除" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user)} 
    context "記事が削除されたとき" do
      it "中間テーブルのデータも削除されること" do
        post.save_tags( ["rspec"] )

        expect{ post.destroy }.to change{ PostTagRelation.count }.by(-1)
      end
    end

  end
end
