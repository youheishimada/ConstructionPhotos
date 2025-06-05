class CreateActionLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :action_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true
      t.string :action_type
      t.text :detail

      t.timestamps
    end
  end
end
