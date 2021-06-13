class CreateHorses < ActiveRecord::Migration[5.1]
  def change
    create_table :horses do |t|
      t.string :name
      t.string :sex
      t.string :color
      t.string :sire_name

      t.timestamps
    end
  end
end
