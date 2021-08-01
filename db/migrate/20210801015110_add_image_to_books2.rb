class AddImageToBooks2 < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :Image, :boolean, default: false, null: false
  end
end
