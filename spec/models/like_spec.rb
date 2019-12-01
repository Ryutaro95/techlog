require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  it "user_idとpost_idがある時有効な状態であること" do
    
  end

  it "user_idがないとき無効な状態であること"

  it "post_idがないとき無効な状態であること"
end
