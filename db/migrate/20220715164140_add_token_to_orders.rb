class AddTokenToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :token, :string
  end
end
