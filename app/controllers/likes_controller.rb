class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    unless @post.like?(current_user)
      @post.post_like(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    if @post.like?(current_user)
      @post.post_unlike(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
