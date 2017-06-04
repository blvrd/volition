class DaysController < ApplicationController
  def show
    @todo_list = current_user.todo_lists.find_by(id: params[:id])
    @reflection = @todo_list.reflection
  end
end
