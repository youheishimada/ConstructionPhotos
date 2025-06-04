# db/migrate/xxxxxx_change_photo_id_nullable_in_action_logs.rb
class ChangePhotoIdNullableInActionLogs < ActiveRecord::Migration[6.1]
  def change
    change_column_null :action_logs, :photo_id, true
  end
end