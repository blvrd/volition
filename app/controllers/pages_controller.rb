class PagesController < AuthenticatedController
  def nice_job
    redirect_to dashboard_path unless current_user.had_a_great_day?
  end

  def welcome
    redirect_to dashboard_path unless current_user.recently_signed_up?
  end

  def thank_you
    redirect_to dashboard_path unless URI(request.referer).path == "/payments/new"
  end
end
