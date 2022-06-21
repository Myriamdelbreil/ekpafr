class AddThemeRefToFormations < ActiveRecord::Migration[7.0]
  def change
    add_reference :formations, :theme, null: false, foreign_key: true
  end
end
