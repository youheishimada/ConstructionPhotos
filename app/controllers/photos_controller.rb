# app/controllers/photos_controller.rb

class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def new
    @photo = @project.photos.build
  end

  def create
    @photo = @project.photos.build(photo_params)
    @photo.user = current_user

    if @photo.save
      tmp_photo_path = Rails.root.join("tmp", "photo_#{@photo.id}.jpg")
      tmp_output_path = Rails.root.join("tmp", "combined_#{@photo.id}.jpg")

      File.open(tmp_photo_path, 'wb') do |f|
        f.write(@photo.image.download)
      end

      text_data = {
        date: @photo.date.strftime("%Y年%m月%d日"),
        work_number: @photo.work_number,
        work_content: @photo.work_content,
        location: @photo.location,
        project_name: @photo.project_name,
        contractor: @photo.contractor
    }

      Magic::BlackboardOverlay.compose_overlay(
        photo_path: tmp_photo_path.to_s,
        output_path: tmp_output_path.to_s,
        text_data: text_data
      )

      File.open(tmp_output_path) do |file|
        @photo.image_with_blackboard.attach(
          io: file,
          filename: "combined_#{@photo.id}.jpg",
          content_type: 'image/jpeg'
        )
      end

      File.delete(tmp_photo_path) if File.exist?(tmp_photo_path)
      File.delete(tmp_output_path) if File.exist?(tmp_output_path)

      redirect_to [@project, @photo], notice: "黒板付き写真を作成しました"
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
  params.require(:photo).permit(
    :image,
    :note,
    :work_number,
    :work_content,
    :location,
    :date,
    :project_name,
    :contractor
  )
  end
end