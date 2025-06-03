class AddImageWithBlackboardToPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :image_with_blackboard, :string  # ダミー（ActiveStorage用に明示的にカラム追加しなくてもOKですが、メモ的に残してもよい）
  end
end