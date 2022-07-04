class CreateOrdes < ActiveRecord::Migration[7.0]
  def change
    create_table :ordes do |t|
      t.integer :status
      t.string :token
      t.string :charge_id
      t.string :error_message
      t.string :customer_id
      t.integer :payment_gateway
      t.references :user, null: false, foreign_key: true
      t.references :formation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
