class AddGoogleIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :google_id, :string
  end
end
