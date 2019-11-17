require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  context "ユーザーが新しいブログ記事を作成したとき" do
    it "作成されること" do
      user = FactoryBot.create(:user, name: "test_user", email: "test@test.com", password: "password")
      visit new_user_session_path

      fill_in "メールアドレス", with: "test@test.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
      
      expect {
        find(".posts-new").click
    
        fill_in "タイトル", with: "テスト記事を作成"
        fill_in "本文", with: "テスト記事の本文を記入する場所です"
        find(".submit-post").click

        expect(page).to have_content "記事を投稿しました"
        expect(page).to have_link "テスト記事を作成"
        expect(page).to have_link "#{user.name}"
      }.to change(user.posts, :count).by(1)
    end
  end

  context "ユーザーが作成したブログの削除ボタンを押下したとき" do
    it "削除されること", js: true do
      user = FactoryBot.create(:user, name: "test_user", email: "test@test.com", password: "password")
      visit new_user_session_path

      fill_in "メールアドレス", with: "test@test.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
      
      find(".posts-new").click

      fill_in "タイトル", with: "テスト記事を作成"
      fill_in "本文", with: "テスト記事の本文を記入する場所です"
      find(".submit-post").click

      expect {
        find(".dropdown-toggle").click
        click_link "マイページ"
        find(".btn-post-delete").click
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content "「テスト記事を作成」を削除しました"
      }.to change(user.posts, :count).by(-1)
    end
  end

  context "ユーザーが作成したブログの編集ボタンを押下して編集したとき" do
    it "編集できること", js: true do
      user = FactoryBot.create(:user, name: "test_user", email: "test@test.com", password: "password")
      visit new_user_session_path

      fill_in "メールアドレス", with: "test@test.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
      
      find(".posts-new").click

      fill_in "タイトル", with: "テスト記事を作成"
      fill_in "本文", with: "テスト記事の本文を記入する場所です"
      find(".submit-post").click
      find(".dropdown-toggle").click
      click_link "マイページ"
      find(".btn-post-edit").click

      fill_in "タイトル", with: "テストタイトルを編集"
      fill_in "本文", with: "テスト記事の本文を編集"
      find(".submit-post").click

      expect(page).to have_content "「テストタイトルを編集」を更新しました"
      expect(page).to have_content "テストタイトルを編集"
      expect(page).to have_content "テスト記事の本文を編集"
      expect(page).to have_link "test_user"
    end
  end
end
