FactoryBot.define do
  factory :project do
    association :user
    title { "テスト工事" }
    site_name { "テスト現場" }
    start_date { Date.today }
    end_date { Date.today + 7 }
  end
end