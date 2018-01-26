class TodayController < ApplicationController
  before_action :set_user
  before_action :verify_that_today_is_trackable

  def show
    @week_plan = current_week_plan
    @reflection = Reflection.today(current_user)
    @todo_list = TodoList.today(@user)
    @button_text, @button_path = if Reflection.today(current_user).present?
                                   ["Plan for tomorrow", tomorrow_path]
                                 else
                                   ["Reflect on your day", reflect_path(date: @todo_list.date)]
                                 end

    if @todo_list.blank?
      redirect_to new_today_path
    else
      @todos = @todo_list.todos.frontend_info
    end
  end

  def new
    if TodoList.today(@user)
      redirect_to today_path
    end

    @todo_list = TodoList.new
    @week_plan = current_week_plan
    5.times do
      @todo_list.daily_todos.new
    end
  end

  def create
    @todo_list = TodoList.new(
      date: Date.current,
      user: @user,
      list_type: 'daily',
      week_plan: current_week_plan
    )
    if @todo_list.save

      @todo_list.update(daily_todos_attributes: daily_todo_list_params[:daily_todos_attributes])
      overlapping_todo_content = @todo_list.todos.pluck(:content) & current_week_plan.todos.pluck(:content)
      if overlapping_todo_content.size > 0
        current_week_plan.todos.where(content: overlapping_todo_content).destroy_all
      end
      redirect_to today_path
    end

  end

  private

  def set_user
    if params[:guest].present?
      @user = User.create!(guest: true, password: SecureRandom.hex)
      login(@user)
    elsif current_user
      @user = current_user
    else
      redirect_to login_path
    end
  end

  def daily_todo_list_params
    params.require(:todo_list).permit(daily_todos_attributes: [:content, :estimated_time_blocks])
  end
end
