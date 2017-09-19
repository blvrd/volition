class ApplicationController < ActionController::Base
  include ApplicationHelper

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

  def ensure_user_paid!
    unless self_hosted? || current_user.paid? || current_user.trialing?
      redirect_to settings_path
    end
  end

  def verify_that_today_is_trackable
    redirect_to dashboard_path unless view_context.today_is_trackable?
  end

  def current_week_plan
    today       = Date.current
    end_of_week = today.at_end_of_week

    @current_week_plan ||= current_user.todo_lists
                                       .weekly
                                       .find_or_create_by(date: end_of_week)
  end
  helper_method :current_week_plan

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
