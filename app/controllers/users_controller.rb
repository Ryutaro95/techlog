class UsersController < ApplicationController
  # before_action :find_user

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10).order(updated_at: :desc)
    @following_posts = @user.following_posts.page(params[:page]).per(10).order(updated_at: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin?
      flash[:alert] = "管理者ユーザーは削除できません"
      redirect_to admin_users_path
    else
      @user.destroy
      flash[:notice] = "#{@user.name}さんのアカウントを凍結しました。"
      redirect_to admin_users_path
    end
  end

  # 凍結（論理削除）されたユーザー一覧
  def deleted_user
    @deleted_users = User.only_deleted
  end
end