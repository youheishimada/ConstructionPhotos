class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to @project, notice: "プロジェクトを作成しました"
    else
      render :new, alert: "作成に失敗しました"
    end
  end

    def show
    @project = current_user.projects.find(params[:id])

    @grouped_photos = @project.photos
      .where(deleted: false)
      .order(created_at: :desc)
      .group_by { |photo| photo.created_at.to_date }
  end

  private

  def project_params
    params.require(:project).permit(:title, :site_name, :start_date, :end_date)
  end
end