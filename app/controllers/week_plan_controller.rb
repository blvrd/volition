class WeekPlanController < ApplicationController
  def show
    @week_plan = current_week_plan
  end

  def add_todo
    @todo = Todo.create(todo_params)

    respond_to do |format|
      format.js
    end
  end
end
