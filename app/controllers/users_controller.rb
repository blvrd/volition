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
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)

    if @user.save
      flash[:success] = 'Settings updated'
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :phone,
      :email_notifications,
      :sms_notifications,
      :track_weekends
    )
  end
end
