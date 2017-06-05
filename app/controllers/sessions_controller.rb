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
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      RefreshStripeCacheJob.perform_later(@user.id)
      login(@user)
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
end
