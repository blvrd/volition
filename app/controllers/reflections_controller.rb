class ReflectionsController < ApplicationController
  before_action :authenticate_user!

  def new
    if Reflection.today(current_user).present?
      flash[:error] = 'You already wrote your reflection for today.'
      redirect_to dashboard_path
    elsif TodoList.today(current_user).blank?
      flash[:error] = 'You must start your tasks for today before writing a reflection.'
      redirect_to dashboard_path
    end

    @reflection = Reflection.new
    @todo_list = TodoList.today(current_user)
  end

  def create
    @reflection = Reflection.new(reflection_params)
    @reflection.user = current_user
    @reflection.date = Date.current

    if @reflection.save
      redirect_to tomorrow_path
    else
      render :new
    end
  end

  private

  def reflection_params
    params.require(:reflection).permit(:rating, :right, :wrong, :undone)
  end
end
