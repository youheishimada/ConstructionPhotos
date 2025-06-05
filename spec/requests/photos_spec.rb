require 'rails_helper'

RSpec.describe "Photos", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  before do
    sign_in user # Devise を使っている場合
  end

  describe "GET /projects/:project_id/photos/new" do
    it "新規作成ページにアクセスできる" do
      get new_project_photo_path(project)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /projects/:project_id/photos" do
    let(:valid_params) do
      {
        photo: {
          image: fixture_file_upload(Rails.root.join('spec/fixtures/files/test.jpg'), 'image/jpeg'),
          work_number: "12345",
          work_content: "舗装作業",
          location: "東京",
          date: Date.today,
          project_name: "テストプロジェクト",
          contractor: "テスト建設"
        }
      }
    end

    it "写真を投稿できる" do
      expect {
        post project_photos_path(project), params: valid_params
      }.to change(Photo, :count).by(1)

      expect(response).to redirect_to(project_photo_path(project, Photo.last))
    end
  end
end

