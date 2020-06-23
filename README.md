# TECHLOG

ITエンジニアリングに関する知識や情報の共有はもちろん、エンジニアリングを通して日々感じたことや考えを書き残すことができるブログサービスです。

<br>


## デモ

[http://techlog-316940954.ap-northeast-1.elb.amazonaws.com/](http://techlog-316940954.ap-northeast-1.elb.amazonaws.com/)

![](https://user-images.githubusercontent.com/45044320/85442859-99b53680-b5cb-11ea-8638-67d70524acf4.png)

かんたんログイン機能を実装しているため、ユーザー登録することなくTECHLOGを体験することができます。

<br>

## 機能一覧
- ログイン機能(Devise)
- ユーザー情報編集
- ユーザープロフィール画像
- ブログ記事 投稿 / 削除 / 編集 / 詳細
  - Markdown記法対応
  - コードをシンタックスハイライトで色分け
- コメント機能 投稿 / 削除
  - コメントの投稿/削除をAjaxで実装
- いいね機能 / いいね解除
  - いいね / いいね解除ボタンをAjaxで実装
- 記事ストック機能 / ストック解除 / ストック記事一覧
  - 記事ストック / 解除ボタンをAjaxで実装
- ユーザーフォロー / フォロー解除 / 一覧
  - フォロー / フォロー解除ボタンをAjaxで実装
- ページネーション(kaminari)
- RSpec で単体テスト / 統合テストを実装


<br>


## 使用技術
### バックエンド
- Ruby 2.6.5
- Ruby on Rails 5.2.3
- MySQL 5.7
- Docker
- docker-compose
- RSpec

### フロントエンド
- Sass
- Bootstrap
- jQuery