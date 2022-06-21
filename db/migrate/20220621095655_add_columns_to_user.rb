class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nom, :string
    add_column :users, :prenom, :string
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :telephone, :string
    add_column :users, :diplome, :string
    add_column :users, :site_connu, :string
    add_column :users, :newsletter, :boolean
    add_column :users, :addresse, :string
    add_column :users, :email_confirmation, :string
  end
end
