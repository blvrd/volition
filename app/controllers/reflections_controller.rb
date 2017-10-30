class ReflectionsController < AuthenticatedController
  include ApplicationHelper

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
      redirect_to after_create_path
    else
      @todo_list = TodoList.today(current_user)
      render :new
    end
  end

  private

  def after_create_path
    if tomorrow_is_trackable?
      tomorrow_path
    else
      flash[:success] = 'Nice job today! Get some rest.'
      dashboard_path
    end
  end

  def reflection_params
    params.require(:reflection).permit(:rating, :positive, :negative, :undone)
  end
end
