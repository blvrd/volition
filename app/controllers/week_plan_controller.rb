class WeekPlanController < ApplicationController
  def show
    @week_plan = current_week_plan
  end

  def add_todo
    @todo = Todo.create(
      content: params[:content],
      todo_list: current_week_plan
    )

    respond_to do |format|
      format.js
    end
  end
end
