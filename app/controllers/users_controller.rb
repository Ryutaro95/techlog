class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id).page(params[:page]).per(10).order(updated_at: :desc)
    @following_posts = @user.following_posts.page(params[:page]).per(10).order(updated_at: :desc)
  end
end