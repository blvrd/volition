class WeekPlanController < ApplicationController
  def show
    @week_plan = current_week_plan
  end

  def add_todo
    @week_plan = current_week_plan
    @todo = Todo.create(
      content: params[:content],
      todo_list: @week_plan
    )

    respond_to do |format|
      format.js
    end
  end
end
