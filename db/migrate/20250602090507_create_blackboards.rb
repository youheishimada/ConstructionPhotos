class CreateBlackboards < ActiveRecord::Migration[7.1]
  def change
    create_table :blackboards do |t|
      t.references :photo, null: false, foreign_key: true
      t.string :work_number
      t.text :work_content
      t.string :location

      t.timestamps
    end
  end
end
