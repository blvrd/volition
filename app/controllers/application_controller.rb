class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  around_action :with_timezone

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def authenticate_user!
    redirect_to login_path unless current_user
  end

  private

  def with_timezone
    begin
      timezone = ActiveSupport::TimeZone.all.find do |tz|
        tz.tzinfo.name == cookies[:timezone].delete('\"')
      end
    rescue
      timezone = ActiveSupport::TimeZone['UTC']
    end

    Time.use_zone(timezone) { yield }
  end
end
