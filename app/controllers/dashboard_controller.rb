class DashboardController < AuthenticatedController
  def show
    if current_user.guest?
      redirect_to today_path
    end

    unless params[:page]
      @tomorrows_todo_list = TodoList.includes(:todos).tomorrow(current_user)
    end

    @todays_todo_list = TodoList.includes(:todos).today(current_user)
    @past_todo_lists = TodoList.includes(:todos).past(current_user).daily.paginate(page: params[:page])
  end
end
