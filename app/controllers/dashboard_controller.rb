class DashboardController < ApplicationController
  def show
    @user = User.first
    @todays_todo_list = @user.todo_lists.where(date: Date.today).first
    @past_todo_lists = @user.todo_lists.where('date != ?', Date.today)
  end
end
