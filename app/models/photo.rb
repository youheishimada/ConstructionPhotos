class Photo < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_one_attached :image
  has_one :blackboard, dependent: :destroy
  has_many :action_logs, dependent: :destroy
  accepts_nested_attributes_for :blackboard
end
