class AddColumnsToFormations < ActiveRecord::Migration[7.0]
  def change
    add_column :formations, :stripe_plan_name, :string
    add_column :formations, :paypal_plan_name, :string
  end
end
