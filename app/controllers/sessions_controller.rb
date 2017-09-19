class SessionsController < ApplicationController
  def new
    if current_user.present?
      if current_user.guest?
        redirect_to new_user_path(guest: true)
      else
        redirect_to dashboard_path
      end
    end
  end

  def create
    authenticated_user = authenticate

    if authenticated_user.present?
      login(authenticated_user)
      redirect_to dashboard_path
    else
      flash.now[:error] = 'The information you entered is incorrect.'
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = 'Logged out.'
    redirect_to login_path
  end

  private

  def authenticate
    google_login = authenticate_with_google
    user = google_login || User.find_by(email: params[:email])

    if google_login.present?
      user
    else
      user && user.password_digest.present? && user.authenticate(params[:password])
    end
  end

  def authenticate_with_google
    if params[:google_id_token].present?
      User.find_by(
        google_id: GoogleSignIn::Identity.new(params[:google_id_token]).user_id)
    end
  end
end
