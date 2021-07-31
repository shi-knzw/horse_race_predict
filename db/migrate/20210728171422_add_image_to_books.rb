class AddImageToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :image, :binary
  end
end
