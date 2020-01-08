class UserFollowRelationsController < ApplicationController
  before_action :set_user
  
  def create
    following = current_user.follow(@user)
    flash[:notice] = 'ユーザーをフォローしました'
    redirect_to @user
  end

  def destroy
    following = current_user.unfollow(@user)
    flash[:notice] = 'ユーザーのフォローを解除しました'
    redirect_to @user
  end

  private

    def set_user
      @user = User.find(params[:follow_id])
    end
end
