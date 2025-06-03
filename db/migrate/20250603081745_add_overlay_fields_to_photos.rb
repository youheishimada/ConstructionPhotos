class AddOverlayFieldsToPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :date, :date
    add_column :photos, :project_name, :string
    add_column :photos, :contractor, :string
  end
end
