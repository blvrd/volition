class ChangeTodoListIds < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :weekly_todo_list_id, :integer
    add_index :todos, :weekly_todo_list_id
    add_foreign_key "todos", "todo_lists", column: "weekly_todo_list_id"

    rename_column :todos, :todo_list_id, :daily_todo_list_id
  end
end
