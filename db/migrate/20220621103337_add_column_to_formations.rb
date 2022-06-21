class AddColumnToFormations < ActiveRecord::Migration[7.0]
  def change
    add_column :formations, :courtedescription, :text
  end
end
