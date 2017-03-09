class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  if Rails.env == 'production'
    http_basic_authenticate_with name: ENV['HTTP_AUTH_USERNAME'], password: ENV['HTTP_AUTH_PASSWORD']
  end

  def new
    if current_user.present? && !current_user.guest?
      redirect_to dashboard_path
    end
    @user = User.new
  end

  def create
    if current_user
      @user = current_user
      @user.assign_attributes(user_params)
      @user.guest = false
    else
      @user = User.new(user_params)
    end

    @user.password_confirmation = user_params[:password]
    @user.timezone = Time.zone.tzinfo.name

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
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      redirect_to settings_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :phone,
      :email_reminders,
      :sms_reminders,
      :track_weekends,
      :password
    )
  end
end
