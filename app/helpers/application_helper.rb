module ApplicationHelper
  def today_is_trackable?
    return true if current_user.track_weekends

    today = Time.current

    false if today.on_weekend?
  end

  def truncate(string, user_agent: :desktop)
    if user_agent == :desktop
      string.truncate(40)
    else
      string.truncate(25)
    end
  end

  def self_hosted?
    ENV['SELF_HOSTED'] == 'true'
  end

  def on_home_page?
    controller.action_name == 'home'
  end
end
