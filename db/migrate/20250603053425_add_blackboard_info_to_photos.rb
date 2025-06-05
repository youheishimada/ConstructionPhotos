class AddBlackboardInfoToPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :work_number, :string
    add_column :photos, :work_content, :string
    add_column :photos, :location, :string
  end
end
