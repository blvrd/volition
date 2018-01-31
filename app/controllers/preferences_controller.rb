class PreferencesController < ApplicationController
  before_action :set_user

  def update
    @user.skip_password_validation = true
    @user.assign_attributes({
      track_weekends: params[:track_weekends],
      weekly_summary: params[:weekly_summary]
    })

    if @user.save
      flash[:success] = "Preferences saved!"
    else
      flash[:error] = "Something went wrong. Please try again."
    end

    redirect_to settings_path
  end

  def update_email
    authenticate_with(params[:password])

    if @user.update(email: params[:email])
      flash[:success] = "Email updated!"
    else
      flash[:error] = "Something went wrong. Please try again."
    end

    redirect_to settings_path
  end

  def update_password
    authenticate_with(params[:current_password])

    if @user.update(password: params[:new_password])
      flash[:success] = "Password updated!"
    else
      flash[:error] = "Something went wrong. Please try again."
    end

    redirect_to settings_path
  end

  private

  def authenticate_with(password)
    unless @user.authenticate(password)
      flash[:error] = "Incorrect password"
      redirect_to settings_path
    end
  end

  def set_user
    @user = current_user
  end
end
