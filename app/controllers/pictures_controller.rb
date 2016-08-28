class PicturesController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user = current_user
    if @picture.save
      redirect_to pictures_path
    else
      render "new"
    end
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])

    if current_user.created_picture?(@picture)
      @picture.update(picture_params)

      redirect_to pictures_path
    else
      redirect_to pictures_path,
      alert: "You do not own this pic!"
    end
  end

  def destroy
    @picture = Picture.find(params[:id])

    if current_user.created_picture?(@picture)
      @picture.destroy

      flash[:notice] = "Picture deleted successfully"
      redirect_to pictures_path
    else
      redirect_to pictures_path,
      alert: "You do not own this pic!"
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:caption, :image)
  end
end
