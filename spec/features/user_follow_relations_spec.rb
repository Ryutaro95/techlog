require 'rails_helper'

RSpec.feature "UserFollowRelations", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, name: "その他のユーザー") }
  let!(:post) { FactoryBot.create(:post, user: other_user) }

  describe "ユーザーフォロー" do
    scenario "その他のユーザーをフォローできる", js: true do
      sign_in_as(user)
      click_link "その他のユーザー"

      expect{
        click_on "フォロー"

        expect(page).to have_button "フォロー解除"
        expect(page).to have_content "ユーザーをフォローしました"
      }.to change(UserFollowRelation, :count).by(1)
    end
  end

  describe "ユーザーフォロー解除" do
    scenario "その他のユーザーをフォロー解除できる", js: true do
      sign_in_as(user)
      click_link "その他のユーザー"
      click_on "フォロー"
      
      expect{
        click_on "フォロー解除"
        expect(page).to have_button "フォロー"
        expect(page).to have_content "ユーザーのフォローを解除しました"
      }.to change(UserFollowRelation, :count).by(-1)
    end
  end
end