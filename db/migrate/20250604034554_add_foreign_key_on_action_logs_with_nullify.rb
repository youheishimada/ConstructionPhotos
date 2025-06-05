class AddForeignKeyOnActionLogsWithNullify < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :action_logs, :photos rescue nil
    add_foreign_key :action_logs, :photos, on_delete: :nullify
  end
end