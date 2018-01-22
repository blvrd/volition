class PasswordsController < ApplicationController
  def new
  end

  def create
    if user = User.find_by(email: params[:email])
      user.forgot_password!
      deliver_email(user)
    end

    flash[:success] = "You will be sent a password recovery email shortly."
    redirect_to login_path
  end

  def edit
    password_reset_token = if params[:token]
                             params[:token]
                           else
                             session[:password_reset_token]
                           end

    @user = User.find_by(
      id: params[:id],
      password_reset_token: password_reset_token
    )

    if @user && @user.eligible_for_password_reset
      session[:password_reset_token] = params[:token]
    else
      flash[:error] = "Either that user doesn't exist or your token has expired."
      redirect_to login_path
    end
  end

  def update
    @user = User.find_by(password_reset_token: session[:password_reset_token])
    @user.password = params[:password]

    if @user.save
      flash[:success] = "Password successfully reset. Please log in to continue."
      redirect_to login_path
    else
      render :edit
    end
  end

  private

  def deliver_email(user)
    PasswordsMailer.change_password(user).deliver_later
  end

  def password_reset_params

  end
end
