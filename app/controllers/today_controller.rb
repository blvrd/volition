class TodayController < ApplicationController
  def show
    unless TodoList.today(current_user)
      redirect_to new_today_path
    end
  end

  def new
    @todo_list = TodoList.new
    5.times do
      @todo_list.todos.build
    end
  end

  def create
    @todo_list = TodoList.new(
      date: Date.today,
      user: current_user
    )

    if @todo_list.save
      @todo_list.update(todos_attributes: todo_list_params[:todos_attributes])
      redirect_to today_path
    end

  end

  private

  def todo_list_params
    params.require(:todo_list).permit(todos_attributes: [:content, :estimated_time_blocks])
  end
end
