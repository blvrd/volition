class ApplicationController < ActionController::Base
  protect_from_forgery

  around_action :with_timezone

  before_action :detect_user_agent

  MOBILE_USER_AGENT = /Mobile|iP(hone|od|ad)|Android|BlackBerry|IEMobile/

  def detect_user_agent
    @user_agent ||= MOBILE_USER_AGENT.match(request.user_agent) ? :mobile : :desktop
  end

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

  def verify_that_today_is_trackable
    redirect_to dashboard_path unless view_context.today_is_trackable?
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
