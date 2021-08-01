class ChangeDataImageToBooks < ActiveRecord::Migration[5.1]
  def change
    change_column:books,:image,:boolean
  end
end
