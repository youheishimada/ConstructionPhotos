FactoryBot.define do
  factory :photo do
    association :user
    association :project
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test.jpg'), 'image/jpeg') }
    note { "テストメモ" }
    work_number { "工事番号001" }
    work_content { "舗装工事" }
    location { "東京都千代田区" }
    date { Date.today }
    project_name { "テストプロジェクト" }
    contractor { "テスト建設" }
  end
end