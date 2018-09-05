class TomorrowController < AuthenticatedController
  def new
    unless skipping_today_or_reflection_to_plan_tomorrow?
      path = if Reflection.today(current_user).present?
               message = "You already planned tomorrow\'s tasks. You can change them when you start your day."
               dashboard_path
             end

      if TodoList.tomorrow(current_user).present?
        flash[:error] = message
        redirect_to path
      end
    end

    @todo_list = TodoList.new
    @week_plan = current_week_plan
    5.times do
      @todo_list.daily_todos.new
    end
  end

  def create
    @todo_list = TodoList.new(
      date: Date.current.next_day,
      user: current_user
    )

    if @todo_list.save
      @todo_list.update(daily_todos_attributes: daily_todo_list_params[:daily_todos_attributes])
      overlapping_todo_content = @todo_list.todos.pluck(:content) & current_week_plan.todos.pluck(:content)
      if overlapping_todo_content.size > 0
        current_week_plan.todos.where(content: overlapping_todo_content).destroy_all
      end
      redirect_to after_create_path
    end

  end

  private

  def skipping_today_or_reflection_to_plan_tomorrow?
    return false if request.referer.blank?

    current_user.paid? && (URI(request.referer).path == "/today/new" || URI(request.referer).path == "reflect")
  end

  def after_create_path
    if current_user.guest?
      new_user_path(guest: true)
    elsif current_user.had_a_great_day?
      nice_job_path
    else
      unless TodoList.today(current_user).blank?
        flash[:success] = 'Nice job today! Get some rest.'
      end
      dashboard_path
    end
  end

  def daily_todo_list_params
    params.require(:todo_list).permit(daily_todos_attributes: [:content, :estimated_time_blocks])
  end
end
