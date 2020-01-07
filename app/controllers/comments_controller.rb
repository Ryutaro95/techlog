class CommentsController < ApplicationController


  def create
    user = current_user
    @comment = user.comments.build(comment_params)
    @comment.post_id = params[:post_id]
    set_comments
    
    respond_to do |format|
      if @result = @comment.save
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    set_comments
    @comment.destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:post_id, :comment)
    end

    def set_comments
      @comments = Comment.where(post_id: @comment.post_id).page(params[:page]).per(5).order(created_at: :desc)
    end
end