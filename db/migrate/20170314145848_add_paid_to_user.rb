class AddPaidToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :paid, :boolean, default: true, null: false
  end
end
