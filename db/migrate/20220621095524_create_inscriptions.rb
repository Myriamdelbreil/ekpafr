class CreateInscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :inscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :formation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
