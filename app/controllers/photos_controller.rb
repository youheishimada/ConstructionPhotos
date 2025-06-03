class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def new
    @photo = @project.photos.build
    @photo.build_blackboard  
  end

  def create
    @photo = @project.photos.build(photo_params)
    @photo.user = current_user
    if @photo.save
      redirect_to [@project, @photo], notice: "写真をアップロードしました"
    else
      render :new, alert: "アップロードに失敗しました"
    end
  end

  def show
    @photo = @project.photos.find(params[:id])
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def photo_params
    params.require(:photo).permit(:image, :note, blackboard_attributes: [:work_number, :work_content, :location])
  end
end
