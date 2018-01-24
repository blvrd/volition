class TomorrowController < AuthenticatedController
  def new
    unless skipping_today_to_plan_tomorrow?
      path = if Reflection.today(current_user).present?
               message = "You already planned tomorrow\'s tasks. You can change them when you start your day."
               dashboard_path
             else
               message = "You must write a reflection for today before planning tomorrow\'s tasks."
               reflect_path
             end

      if TodoList.tomorrow(current_user).present? ||
          Reflection.today(current_user).blank?
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
      @todo_list.update(daily_todos_attributes: todo_list_params[:daily_todos_attributes])
      redirect_to after_create_path
    end

  end

  private

  def skipping_today_to_plan_tomorrow?
    return false if request.referer.blank?

    current_user.paid? && URI(request.referer).path == "/today/new"
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

  def todo_list_params
    params.require(:todo_list).permit(daily_todos_attributes: [:content, :estimated_time_blocks])
  end
end
