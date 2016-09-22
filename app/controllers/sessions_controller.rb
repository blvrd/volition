class SessionsController < ApplicationController
  def new
    if current_user.present?
      redirect_to dashboard_path
    end
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      login(@user)
      redirect_to dashboard_path
    else
      flash[:error] = 'The information you entered is incorrect.'
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = 'Logged out.'
    redirect_to login_path
  end
end
