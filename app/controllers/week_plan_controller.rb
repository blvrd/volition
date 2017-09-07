class WeekPlanController < AuthenticatedController
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

  def remove_todo
    @week_plan = current_week_plan
    @todo = @week_plan.todos.find_by(id: params[:id])

    if @todo
      @todo.destroy
    end

    respond_to do |format|
      format.js
    end
  end
end
