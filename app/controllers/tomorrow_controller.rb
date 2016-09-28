class TomorrowController < ApplicationController
  before_action :authenticate_user!

  def new
    if Reflection.today(current_user).blank?
      flash[:error] = 'You must write a reflection for today before planning tomorrow\'s tasks.'
      redirect_to reflect_path
    elsif TodoList.tomorrow(current_user).present?
      flash[:error] = 'You already planned tomorrow\'s tasks. You can change them when you start your day.'
      redirect_to reflect_path
    end

    @todo_list = TodoList.new
    5.times do
      @todo_list.todos.build
    end
  end

  def create
    @todo_list = TodoList.new(
      date: Date.current.next_day,
      user: current_user
    )

    if @todo_list.save
      @todo_list.update(todos_attributes: todo_list_params[:todos_attributes])
      flash[:success] = 'Nice job today! Get some rest.'
      redirect_to dashboard_path
    end

  end

  private

  def todo_list_params
    params.require(:todo_list).permit(todos_attributes: [:content, :estimated_time_blocks])
  end
end
