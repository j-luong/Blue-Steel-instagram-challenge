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

    if current_user.has_commented?(@picture)
      @comment.update(comment_params)

      redirect_to "/pictures/#{@picture.id}"
    else
      redirect_to "/pictures/#{@picture.id}",
      alert: "You do not make this comment!"
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @comment = Comment.find(params[:picture_id])

    if current_user.has_commented?(@picture)
      @comment.destroy

      flash[:notice] = "Comment deleted successfully"
      redirect_to "/pictures/#{@picture.id}"
    else
      redirect_to "/pictures/#{@picture.id}",
      alert: "You do not make this comment!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
