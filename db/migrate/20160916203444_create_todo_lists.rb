class CreateTodoLists < ActiveRecord::Migration[5.0]
  def change
    create_table :todo_lists do |t|
      t.references :user, foreign_key: true
      t.datetime :date

      t.timestamps
    end
  end
end
