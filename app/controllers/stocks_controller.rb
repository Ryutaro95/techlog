class StocksController < ApplicationController
  before_action :authenticate_user!
  def index
    # ログインユーザーがストックしている記事一覧を取得して10件単位でページネーション
    @stock_posts = Kaminari.paginate_array(current_user.stocks.map(&:post))
    .page(params[:page]).per(10)
  end

  def create
    @post = Post.find(params[:post_id])
    unless @post.stocked?(current_user)
      @post.stock(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @post = Stock.find(params[:id]).post
    if @post.stocked?(current_user)
      @post.unstock(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
