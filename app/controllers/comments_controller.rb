class CommentsController < ApplicationController
  def new
    @picture = Picture.find(params[:picture_id])
    @comment = Comment.new
  end

  def create
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.new(comment_params)

    if @comment.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render "new"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
