class CommentsController < ApplicationController
  def new
    @picture = Picture.find(params[:picture_id])
    @comment = Comment.new
  end

  def create
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render "new"
    end
  end

  def edit
    @comment = Comment.find(params[:picture_id])
  end

  def update
    @picture = Picture.find(params[:id])

    @comment = Comment.find(params[:picture_id])
    @comment.update(comment_params)

    redirect_to "/pictures/#{@picture.id}"
  end

  def destroy
    @picture = Picture.find(params[:id])
    @comment = Comment.find(params[:picture_id])
    @comment.destroy

    flash[:notice] = "Comment deleted successfully"
    redirect_to "/pictures/#{@picture.id}"
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
