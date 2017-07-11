class AddListTypeToTodoList < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_lists, :list_type, :string, default: :daily, null: false
  end
end
