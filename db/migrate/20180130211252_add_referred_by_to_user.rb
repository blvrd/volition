class AddReferredByToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :referred_by, :integer
    add_index :users, :referred_by
  end
end
