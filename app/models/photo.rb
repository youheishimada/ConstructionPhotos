class Photo < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_one_attached :image
  has_one_attached :image_with_blackboard

  has_one :blackboard, dependent: :destroy
  has_many :action_logs, dependent: :nullify

  accepts_nested_attributes_for :blackboard

  # ✅ 入力必須のバリデーション
  validates :image, :work_number, :work_content, :location, presence: true
  validates :date, presence: true
end
