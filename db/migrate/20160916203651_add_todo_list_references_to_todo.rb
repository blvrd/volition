class AddTodoListReferencesToTodo < ActiveRecord::Migration[5.0]
  def change
    add_reference :todos, :todo_list, foreign_key: true
  end
end
