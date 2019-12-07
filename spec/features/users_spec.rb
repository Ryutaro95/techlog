require 'rails_helper'

RSpec.feature "Users", type: :feature do

  let(:user) { FactoryBot.create(:user) }

  describe "ログイン" do
    context "メールアドレスとパスワードがあるとき" do
      scenario "ログインできる" do
        sign_in_as(user)

        expect(page).to have_content "ログインしました。"
        expect(page).to have_link user.name
      end
    end

    context "メールアドレスがないとき" do
      scenario "ログインできない" do
        visit root_path
        click_link "ログイン"
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: user.password
        click_button "ログイン"
  
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end

    context "パスワードがないとき" do
      scenario "ログインできない" do
        visit root_path
        click_link "ログイン"
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: ""
        click_button "ログイン"
  
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end
  end

  describe "ログアウト" do
    scenario "ログアウトボタンを押下してログアウトする", js: true do
      sign_in_as(user)
  
      find(".dropdown-toggle").click
      click_link "ログアウト"
  
      expect(page).to have_content "ログアウトしました。"
      expect(page).to have_link "ログイン"
      expect(page).to have_link "アカウント作成"
    end
  end

  describe "ユーザー詳細ページ" do
    scenario "マイページに遷移できる", js: true do
      sign_in_as(user)
      find(".dropdown-toggle").click
      click_link "マイページ"

      expect(page).to have_content ": #{user.name}"
      expect(page).to have_content ": #{user.email}"
    end
  end
end
