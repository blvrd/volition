class ChangeDateColumnType < ActiveRecord::Migration[5.0]
  def change
    change_column :todo_lists, :date, :date
    change_column :reflections, :date, :date
  end
end
