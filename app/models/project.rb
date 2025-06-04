class Project < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates :title, presence: true
  validates :site_name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end