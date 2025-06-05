require 'rails_helper'

RSpec.describe '黒板付き写真投稿', type: :system do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  before do
    driven_by(:rack_test)
    login_as(user, scope: :user) # Devise のログインヘルパー
  end

  it '必要な情報を入力すると写真が投稿できる' do
    visit new_project_photo_path(project)

    attach_file 'photo_image', Rails.root.join('spec/fixtures/files/test.jpg')
    fill_in 'photo_work_number', with: '工事番号123'
    fill_in 'photo_work_content', with: '舗装工事'
    fill_in 'photo_location', with: '東京都中央区'
    fill_in 'photo_date', with: Date.today.strftime('%Y-%m-%d')

    click_button 'アップロード'

    expect(page).to have_content('黒板付き写真を作成しました')
  end
end