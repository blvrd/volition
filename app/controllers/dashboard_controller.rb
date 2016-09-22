class DashboardController < ApplicationController
  before_action :authenticate_user!
  def show
    @todays_todo_list = TodoList.today(current_user)
    @past_todo_lists = TodoList.past(current_user)
  end
end
