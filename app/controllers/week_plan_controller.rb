class WeekPlanController < AuthenticatedController
  def show
    @last_week = get_last_week
    @week_plan = get_current_or_upcoming_week
  end

  def add_todo
    @week_plan = get_current_or_upcoming_week
    @todo = Todo.create!(
      content: params[:content],
      weekly_todo_list: @week_plan
    )

    respond_to do |format|
      format.js
    end
  end

  def remove_todo
    @week_plan = get_current_or_upcoming_week
    @todo = @week_plan.todos.find_by(id: params[:id])

    if @todo
      @todo.destroy
    end

    respond_to do |format|
      format.js
    end
  end

  def move_todo
    @last_week = get_last_week
    @week_plan = get_current_or_upcoming_week
    @todo = @last_week.todos.find_by(id: params[:id])

    if @todo
      @todo.update(
        weekly_todo_list_id: @week_plan.id,
        daily_todo_list: nil
      )
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def get_last_week
    if Date.current.sunday?
      current_week_plan
    else
      beginning_of_last_week = Date.current.last_week
      current_user.todo_lists
        .weekly
        .find_by(date: beginning_of_last_week)
    end
  end

  def get_current_or_upcoming_week
    if Date.current.sunday?
      current_user.todo_lists.find_or_create_by(
        list_type: "weekly",
        date: ((@last_week&.date || Date.current) + 1.week).beginning_of_week
      )
    else
      current_week_plan
    end
  end
end
