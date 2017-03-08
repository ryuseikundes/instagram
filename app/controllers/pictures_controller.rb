class PicturesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_blog, only: [:edit, :update, :destroy]



  def index
   @pictures = Picture.all
  end

  def new
   @picture = Picture.new
  end

  def create
   @picture =  Picture.new(pictures_params)
   @picture.user_id = current_user.id
    if @picture.save
     redirect_to root_path, notice: "写真をアップロードしました！"
     NoticeMailer.sendmail_picture(@picture).deliver
    else
     render 'new'
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
     if @picture.update(pictures_params)
       redirect_to root_path, notice:"更新しました！"
     else
       render'edit'
     end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to root_path
  end

  private
    def pictures_params
      params.require(:picture).permit(:title, :content, :image, :image_cache, :remove_image)
    end

    def set_blog
      @picture = Picture.find(params[:id])
    end

end
