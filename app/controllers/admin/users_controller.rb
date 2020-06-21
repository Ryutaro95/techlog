class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.where(admin: false).page(params[:page]).per(10).order(updated_at: :desc)
  end

  private
  
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
