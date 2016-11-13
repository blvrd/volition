module ApplicationHelper
  def today_is_trackable?
    return true if current_user.track_weekends

    today = Time.current

    false if today.on_weekend?
  end
end
