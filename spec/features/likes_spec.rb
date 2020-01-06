require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, name: "その他のユーザー") }
  let!(:post) { FactoryBot.create(:post, user: other_user) }

  describe "ブログ記事をいいね" do
    scenario "他のユーザーが投稿したブログ記事をいいねできる", js: true do
      sign_in_as(user)
      click_link "ブログ記事タイトル"

      expect{
        within ".like-button" do
          find(".like-btn").click
        end
        expect(page).to have_css ".unlike-btn"
      }.to change(Like, :count).by(1)
    end
  end

  describe "ブログ記事のいいね解除" do
    scenario "いいねした記事をいいね解除する", js: true do
      sign_in_as(user)
        click_link "ブログ記事タイトル"
        within ".like-button" do
          find(".like-btn").click
        end
        sleep 3
  
        expect{
          within ".like-button" do
            find(".unlike-btn").click
          end
          expect(page).to have_css ".like-btn"
        }.to change(Like, :count).by(-1)
    end
  end
end