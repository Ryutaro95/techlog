class PostsController < ApplicationController
  before_action :set_post, only: %i(show destroy)

  def index
    @posts = Post.page(params[:page]).per(10).order(updated_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    user = current_user
    @post = user.posts.build(post_params)
    if @post.save
      flash[:notice] = "記事を投稿しました"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id).page(params[:page]).per(10).order(created_at: :desc)
  end

  def destroy
    
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def set_post
      @post = Post.find_by(id: params[:id])
    end
end