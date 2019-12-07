require 'rails_helper'

RSpec.describe Stock, type: :model do

  describe "必須チェック" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: other_user)}

    context "user_idとpost_idがあるとき" do
      it "記事がストックされること" do
        expect{ post.stock(user) }.to change{ Stock.count }.by(1)
      end
    end

    context "user_idがないとき" do
      it "記事がストックされないこと" do
        post.stocks.create(user_id: nil)

        expect(Stock.count).to eq 0
      end
    end

    context "post_idがないとき" do
      it "記事がストックされないこと" do
        Stock.create(user: user)

        expect(Stock.count).to eq 0
      end
    end
  end
end
