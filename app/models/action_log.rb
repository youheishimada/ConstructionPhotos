class ActionLog < ApplicationRecord
  belongs_to :user
 belongs_to :photo, optional: true
end
