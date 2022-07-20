class AddOrdersRefToInscriptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :inscriptions, :order, null: false, foreign_key: true
  end
end
