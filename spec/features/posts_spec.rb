require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  describe "記事投稿" do
    context "タイトルと本文があるとき" do
      scenario "ユーザーが記事を投稿する" do
        sign_in_as(user)

        find(".posts-new").click
        fill_in "タイトル", with: "テスト記事を作成"
        fill_in "本文", with: "テスト記事の本文を記入する場所です"
        expect {
          find(".submit-post").click
        }.to change(user.posts, :count).by(1)
        expect(page).to have_content "記事を投稿しました"
        expect(page).to have_link "テスト記事を作成"
        expect(page).to have_link "#{user.name}"
      end
    end

    context "タイトルが空のとき" do
      scenario "ユーザーは記事を投稿できない" do
        sign_in_as(user)

        find(".posts-new").click
        fill_in "タイトル", with: ""
        fill_in "本文", with: "テスト記事の本文を記入する場所です"
        expect {
          find(".submit-post").click
        }.to change(user.posts, :count).by(0)
        expect(page).to have_content "タイトルを入力してください"
      end
    end

    context "本文が空のとき" do
      scenario "ユーザーは記事を投稿できない" do
        sign_in_as(user)

        find(".posts-new").click
        fill_in "タイトル", with: "記事を投稿しました"
        fill_in "本文", with: ""
        expect {
          find(".submit-post").click
        }.to change(user.posts, :count).by(0)
        expect(page).to have_content "本文を入力してください"
      end
    end
  end

  describe "記事の削除" do
    context "投稿ユーザーが削除ボタンを押したとき" do
      scenario "記事が削除される", js: true do
        sign_in_as(user)
        create_post
        find(".dropdown-toggle").click
        click_link "マイページ"
        find(".us-myposts").click
        find(".btn-post-delete").click
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content "「テスト記事を作成」を削除しました"
      end
    end

    context "投稿ユーザー以外が記事を削除しようとしたとき" do
      scenario "削除ボタンが表示されない", js: true do
        sign_in_as(user)
        create_post
        find(".dropdown-toggle").click
        click_link "ログアウト"

        other_user = FactoryBot.create(:user, name: "other_user")
        sign_in_as(other_user)
        within ".post-items" do
          click_link user.name
        end
        find(".us-myposts").click

        expect(page).to have_link "テスト記事を作成"
        expect(page).to_not have_link "削除"
      end
    end
  end

  describe "記事の編集" do
    context "投稿ユーザーが記事を編集したとき" do
      it "編集が適用される", js: true do
        sign_in_as(user)
        create_post
        find(".dropdown-toggle").click
        click_link "マイページ"
        find(".us-myposts").click
        find(".btn-post-edit").click
  
        fill_in "タイトル", with: "テストタイトルを編集"
        fill_in "本文", with: "テスト記事の本文を編集"
        find(".submit-post").click
  
        expect(page).to have_content "「テストタイトルを編集」を更新しました"
        expect(page).to have_content "テストタイトルを編集"
        expect(page).to have_content "テスト記事の本文を編集"
        expect(page).to have_link user.name
      end
    end

    context "投稿ユーザー以外が記事を編集しようとしたとき" do
      scenario "編集ボタンが表示されない", js: true do
        sign_in_as(user)
        create_post
        find(".dropdown-toggle").click
        click_link "ログアウト"

        other_user = FactoryBot.create(:user, name: "other_user")
        sign_in_as(other_user)
        within ".post-items" do
          click_link user.name
        end
        find(".us-myposts").click

        expect(page).to have_link "テスト記事を作成"
        within ".user-posts-btns" do
          expect(page).to_not have_link "編集"
        end

      end
    end

  end
end