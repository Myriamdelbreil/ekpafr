class CreateTemoignages < ActiveRecord::Migration[7.0]
  def change
    create_table :temoignages do |t|
      t.string :titre
      t.text :contenu

      t.timestamps
    end
  end
end
