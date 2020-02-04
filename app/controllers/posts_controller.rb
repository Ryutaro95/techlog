class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i(new create edit update destroy)
  before_action :correct_user, only: %i(edit update destroy)

  def index
    @posts = Post.page(params[:page]).per(10).order(updated_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      @post.save_tags(tag_params[:tag_names])
      flash[:notice] = "記事を投稿しました"
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(5).order(created_at: :desc)
  end

  def edit
  end
  
  def update
    @post.update(post_params)
    flash[:notice] = "「#{@post.title}」を更新しました"
    redirect_to post_path
  end

  def destroy
    @post.destroy
    flash[:notice] = "「#{@post.title}」を削除しました"
    redirect_back fallback_location: root_path
  end

  def search
    posts = Tag.search(params[:search])
    @posts = Post.where(id: posts.map(&:ids).join(",").split(",")).page(params[:page]).per(10).order(updated_at: :desc)
    render 'index'
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def tag_params
      params.require(:post).permit(:tag_names)
    end

    def correct_user
      @post = Post.find(params[:id])
      redirect_to root_path unless current_user.id == @post.user_id
    end
end