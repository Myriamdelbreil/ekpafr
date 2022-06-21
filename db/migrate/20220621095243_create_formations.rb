class CreateFormations < ActiveRecord::Migration[7.0]
  def change
    create_table :formations do |t|
      t.string :titre
      t.integer :prix
      t.text :description
      t.string :lieu
      t.float :note
      t.string :liencpf
      t.string :duree
      t.boolean :certifiee

      t.timestamps
    end
  end
end
