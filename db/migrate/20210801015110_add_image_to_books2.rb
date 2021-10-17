class AddImageToBooks2 < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :image, :binary
    add_column :books, :image, :boolean, default: false, null: false
  end
end
