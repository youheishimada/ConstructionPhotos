class AddDeletedToPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :deleted, :boolean
  end
end
