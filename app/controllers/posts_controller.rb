class PostsController < ApplicationController

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
    @post = Post.find_by(id: params[:id])
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end