class StocksController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    unless @post.stock?(current_user)
      @post.stock(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    if @post.stock?(current_user)
      @post.unstock(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
