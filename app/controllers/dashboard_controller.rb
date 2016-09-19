class DashboardController < ApplicationController
  def show
    @user = User.first
    login(@user)
    @todays_todo_list = TodoList.today(@user)
    @past_todo_lists = TodoList.past(@user)
  end
end
