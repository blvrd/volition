class ReflectionsController < ApplicationController
  def new
    if Reflection.today(current_user).present?
      flash[:error] = 'You already wrote your reflection for today.'
      redirect_to dashboard_path
    end
    @reflection = Reflection.new
  end

  def create
    @reflection = Reflection.new(reflection_params)
    @reflection.user = current_user
    @reflection.date = Date.today

    if @reflection.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def reflection_params
    params.require(:reflection).permit(:rating, :right, :wrong, :undone)
  end
end
