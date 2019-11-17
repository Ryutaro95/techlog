require 'rails_helper'

RSpec.feature "Users", type: :feature do
  it "ログインする" do
    user = FactoryBot.create(:user, name: "test_user", email: "test@test.com", password: "password")
    
    visit new_user_session_path

    fill_in "メールアドレス", with: "test@test.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"
    expect(page).to have_link "#{user.name}"
  end

  it "ログアウトする", js: true do
    user = FactoryBot.create(:user, name: "test_user", email: "test@test.com", password: "password")
    
    visit new_user_session_path

    fill_in "メールアドレス", with: "test@test.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"

    find(".dropdown-toggle").click
    click_link "ログアウト"

    expect(page).to have_content "ログアウトしました。"
    expect(page).to have_link "ログイン"
    expect(page).to have_link "アカウント作成"
  end

  it "ユーザーのマイページに遷移する", js: true do
    user = FactoryBot.create(:user, name: "test_user", email: "test@test.com", password: "password")
    
    visit new_user_session_path

    fill_in "メールアドレス", with: "test@test.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"

    find(".dropdown-toggle").click

    click_link "マイページ"

    expect(page).to have_content ": #{user.name}"
    expect(page).to have_content ": #{user.email}"

  end
end
