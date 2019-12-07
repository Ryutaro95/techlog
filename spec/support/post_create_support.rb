module PostCreateSupport
  def create_post
    # headerの「記事投稿」リンクをクリック
    find(".posts-new").click
    fill_in "タイトル", with: "テスト記事を作成"
    fill_in "本文", with: "テスト記事の本文を記入する場所です"
    # 「投稿」ボタンをクリック
    find(".submit-post").click
  end
end

RSpec.configure do |config|
  config.include PostCreateSupport
end
