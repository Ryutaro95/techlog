require 'rails_helper'

RSpec.feature "Stocks", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user) }
  let(:to_stock_user) { FactoryBot.create(:user, name: "ストックユーザー") }

  describe "記事をストック" do
    scenario "他のユーザーが投稿した記事をストックできる", js: true do
      sign_in_as(to_stock_user)
      click_link "ブログ記事タイトル"

      expect{
        within ".post-buttons" do
          find(".stock-btn").click
        end
        expect(page).to have_css ".form-unstock"
      }.to change(Stock, :count).by(1)
    end
  end

  describe "記事のストック解除" do
    scenario "ストックした記事を解除する", js: true do
      sign_in_as(to_stock_user)
      click_link "ブログ記事タイトル"
      within ".post-buttons" do
        find(".stock-btn").click
      end
      sleep 3

      expect{
        within ".post-buttons" do
          find(".unstock-btn").click
        end
        expect(page).to have_css ".form-stock"
      }.to change(Stock, :count).by(-1)
    end
  end

  describe "ストック一覧表示" do
    scenario "ストックした記事が一覧ページに表示されている", js: true do
      sign_in_as(to_stock_user)
      click_link "ブログ記事タイトル"
      within ".post-buttons" do
        find(".stock-btn").click
      end
      find(".dropdown-toggle").click
      click_link "ストック一覧"

      expect(page).to have_content "ストック一覧"
      expect(page).to have_content "ブログ記事タイトル"
      expect(page).to have_link user.name
    end
  end
end