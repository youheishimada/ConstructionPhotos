# app/controllers/photos_controller.rb

class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def new
    @photo = @project.photos.build
  end

  def create
    @photo = @project.photos.build(photo_params)
    @photo.user = current_user

    if @photo.save
      tmp_photo_path = Rails.root.join("tmp", "photo_#{@photo.id}.jpg")
      tmp_output_path = Rails.root.join("tmp", "combined_#{@photo.id}.jpg")

      File.open(tmp_photo_path, 'wb') { |f| f.write(@photo.image.download) }

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
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      ActionLog.create!(user: current_user, photo: @photo, action_type: "edit")
      redirect_to [@project, @photo], notice: "写真情報を更新しました。"
    else
      render :edit, alert: "更新に失敗しました。"
    end
  end

def destroy
  deleted_photo_id = @photo.id

  # 削除前にログを記録
  ActionLog.create!(
    user: current_user,
    photo: @photo, # 関連付ける
    action_type: "destroy",
    detail: "Photo ID #{deleted_photo_id} を削除しました"
  )

  @photo.destroy

  redirect_to project_path(@project), notice: "写真を削除しました。"
end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_photo
    @photo = @project.photos.find(params[:id])
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