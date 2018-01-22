class ChangeForeignKeyToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :daily_snapshots, :todo_list_id, :integer
  end
end
