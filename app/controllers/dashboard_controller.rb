class DashboardController < AuthenticatedController
  def show
    if current_user.guest?
      redirect_to today_path
    end

    unless params[:page]
      @tomorrows_todo_list = TodoList.includes(:daily_todos).tomorrow(current_user)
    end

    @todays_todo_list = TodoList.today(current_user)&.daily_snapshot ||
      TodoList.includes(:daily_todos, :user).today(current_user)

    @past_todo_lists = current_user.daily_snapshots.order(date: :desc)
                                   .paginate(page: params[:page])
  end
end
