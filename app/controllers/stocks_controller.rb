class StocksController < ApplicationController
  before_action :authenticate_user!, only: %i(index create destroy)

  def index
    stock_posts = Stock.get_stock_posts(current_user)
    @stock_posts = Kaminari.paginate_array(stock_posts).page(params[:page]).per(10)
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
