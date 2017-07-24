class AddWeekPlanIdToTodoList < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_lists, :week_plan_id, :integer
  end
end
