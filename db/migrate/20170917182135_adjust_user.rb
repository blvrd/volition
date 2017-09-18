class AdjustUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :paid, :boolean,  default: false, null: false
    remove_column :users, :stripe_customer_id
    remove_column :users, :stripe_subscription_id
    add_column :users, :stripe_charge_id, :string
  end
end
