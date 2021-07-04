class AddColumnBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :name, :string, null: false
    add_column :books, :price, :integer, null: false
    add_column :books, :image_url, :string
    add_column :books, :availability, :boolean, default: true, null: false
  end
end
