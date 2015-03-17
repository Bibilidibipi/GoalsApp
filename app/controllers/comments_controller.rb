class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    match = /( )[^ ]*(_id)/.match(params.keys.join(' '))
    cls = match[0][1..-4]
    @commentable = cls.capitalize.constantize.find(params[match[0][1..-1].to_sym])
  end

  def create
    @comment = current_user.authored_comments.new(comment_params)
    match = /( )[^ ]*(_id)/.match(params.keys.join(' '))
    cls = match[0][1..-4]
    @comment.commentable_id = params[match[0][1..-1].to_sym]
    @comment.commentable_type = cls.capitalize

    if @comment.save
      redirect_to @comment.commentable
    else
      flash.now[:errors] = @comment.errors.full_messages
      @commentable = @comment.commentable
      render :new
    end
  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
