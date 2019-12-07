require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user) }
  let(:to_comment_user) { FactoryBot.create(:user, name: "comment user") }

  describe "コメント投稿" do
    context "自身の投稿にコメントしたとき" do
      scenario "コメントできる", js: true do
        sign_in_as(user)
        within ".post-items" do
          click_link post.title
        end
        
        expect{
          fill_in "input-text", with: "コメントを投稿します"
          # 投稿ボタン
          find(".btn-comment-post").click
          within ".comment-username-time" do
            expect(page).to have_link user.name
          end
          expect(page).to have_content "コメントを投稿します"
        }.to change(post.comments, :count).by(1)
      end
    end

    context "他のユーザーがコメントを入力したとき" do
      scenario "コメントできる", js: true do
        sign_in_as(to_comment_user)
        within ".post-items" do
          click_link post.title
        end
        
        expect{
          fill_in "input-text", with: "コメントを投稿します"
          # 投稿ボタン
          find(".btn-comment-post").click
          within ".comment-username-time" do
            expect(page).to have_link to_comment_user.name
          end
          expect(page).to have_content "コメントを投稿します"
        }.to change(post.comments, :count).by(1)
      end
    end
  end

  describe "コメント削除" do
    context "自身のコメントのとき" do
      scenario "削除できる", js: true do
        sign_in_as(user)
        within ".post-items" do
          click_link post.title
        end
        fill_in "input-text", with: "コメントを投稿します"
        # 投稿ボタン
        find(".btn-comment-post").click

        # 削除前にコメントがあることを確認
        expect(page).to have_content "コメントを投稿します"
        within ".comment-delete" do
          click_link "削除"
        end
        page.driver.browser.switch_to.alert.accept

        # 削除後コメントがなくなっていることを確認
        within ".comment-username-time" do
          expect(page).to_not have_link to_comment_user.name
        end
        expect(page).to_not have_content "コメントを投稿します"
      end
    end

    context "その他ユーザーのコメントのとき" do
      scenario "削除ボタンが表示されない", js: true do
        sign_in_as(user)
        within ".post-items" do
          click_link post.title
        end
        fill_in "input-text", with: "コメントを投稿します"
        # 投稿ボタン
        find(".btn-comment-post").click

        # コメント投稿後ログアウト
        find(".dropdown-toggle").click
        click_link "ログアウト"

        sign_in_as(to_comment_user)
        within ".post-items" do
          click_link post.title
        end

        expect(page).to_not have_link "削除"
      end
    end
  end
end