class UsersController < ApplicationController
  def new
    if current_user.present?
      redirect_to dashboard_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password_confirmation = user_params[:password]

    if @user.save
      login(@user)
      redirect_to welcome_path
    else
      render :new
    end
  end

  def edit
    @form = UpdateUserForm.new
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
