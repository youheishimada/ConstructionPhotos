require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  context 'バリデーションのテスト' do
    it 'すべての属性があれば有効' do
      photo = build(:photo, user: user, project: project)
      expect(photo).to be_valid
    end

    it '画像がなければ無効' do
      photo = build(:photo, image: nil, user: user, project: project)
      expect(photo).to be_invalid
      expect(photo.errors[:image]).to include("を入力してください")
    end

    it '工事日がなければ無効' do
      photo = build(:photo, date: nil, user: user, project: project)
      expect(photo).to be_invalid
    end

    it 'ユーザーが紐づいていなければ無効' do
      photo = build(:photo, user: nil, project: project)
      expect(photo).to be_invalid
    end

    it 'プロジェクトが紐づいていなければ無効' do
      photo = build(:photo, project: nil, user: user)
      expect(photo).to be_invalid
    end
  end
end