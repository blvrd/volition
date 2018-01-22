class WeeklySummaryMailer < ApplicationMailer
  default from: "summary@usevolition.com"

  def weekly_summary(user)
    from = 6.days.ago
    to = Date.current.end_of_day
    @user = user
    @weekly_summary = user.weekly_summaries.find_or_create_by(created_at: Date.current.beginning_of_day..Time.current)
    @weekly_summary.update(
      todo_list_ids: user.todo_lists.where(created_at: from..to).pluck(:id)
    )
    @weekly_summary.generate_stats

    @completion_percentage_arrow, @completion_percentage_class = @weekly_summary.arrow_and_class(:completion_percentage)

    @average_rating_arrow, @average_rating_class = @weekly_summary.arrow_and_class(:weekly_rating)

    @recommendation = @weekly_summary.recommendation

    reflections = @weekly_summary.reflections
    @negative = reflections.map(&:negative).uniq
    @positive = reflections.map(&:positive).uniq

    mail(to: @user.email, subject: "[Volition] Your weekly summary")
  end
end
