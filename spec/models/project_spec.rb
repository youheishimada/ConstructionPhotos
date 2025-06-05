require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { FactoryBot.create(:user) }
  
  context 'バリデーションのテスト' do
    it '全ての項目が存在すれば有効である' do
      project = Project.new(
        user: user,
        title: "テスト工事",
        site_name: "テスト現場",
        start_date: Date.today,
        end_date: Date.today + 7
      )
      expect(project).to be_valid
    end

    it '工事件名が空だと無効である' do
      project = Project.new(
        user: user,
        title: '',
        site_name: "テスト現場",
        start_date: Date.today,
        end_date: Date.today + 7
      )
      expect(project).to be_invalid
      expect(project.errors[:title]).to include("を入力してください")
    end

    it '現場名が空だと無効である' do
      project = Project.new(
        user: user,
        title: "テスト工事",
        site_name: '',
        start_date: Date.today,
        end_date: Date.today + 7
      )
      expect(project).to be_invalid
    end

    it '開始日が空だと無効である' do
      project = Project.new(
        user: user,
        title: "テスト工事",
        site_name: "テスト現場",
        start_date: nil,
        end_date: Date.today + 7
      )
      expect(project).to be_invalid
    end

    it '終了日が空だと無効である' do
      project = Project.new(
        user: user,
        title: "テスト工事",
        site_name: "テスト現場",
        start_date: Date.today,
        end_date: nil
      )
      expect(project).to be_invalid
    end
  end
end