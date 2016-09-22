class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @todays_todo_list = TodoList.includes(:todos).today(current_user)
    @past_todo_lists = TodoList.includes(:todos).past(current_user)
  end
end
