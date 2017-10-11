class WeeklySummaryMailer < ApplicationMailer
  default from: "summary@usevolition.com"

  def weekly_summary(user)
    @user = user
    date_args_last_week = { from: 12.days.ago, to: 6.days.ago }
    date_args_this_week = { from: 6.days.ago, to: Date.current.end_of_day }
    @completion_percentage = user.completion_percentage(**date_args_this_week)
    @average_rating = user.average_rating(**date_args_this_week)
    @completion_percentage_last_week = user.completion_percentage(**date_args_last_week)
    @average_rating_last_week = user.average_rating(**date_args_last_week)
    @completion_percentage_arrow, @completion_percentage_class = if @completion_percentage > @completion_percentage_last_week
                                                                   ["&#9650;", "better"]
                                                                 elsif @completion_percentage < @completion_percentage_last_week
                                                                   ["&#9660;", "worse"]
                                                                 else
                                                                   "&minus;"
                                                                 end

    @average_rating_arrow, @average_rating_class = if @average_rating > @average_rating_last_week
                                                     ["&#9650;", "better"]
                                                   elsif @average_rating < @average_rating_last_week
                                                     ["&#9660;", "worse"]
                                                   else
                                                     "&minus;"
                                                   end

    @recommendation = if @completion_percentage < 70 && @average_rating < 7
                        "It looks like you didn't get everything done this past week and that reflected on how productive you thought your days were. Try being more deliberate in planning your tasks this coming week in order to build momentum."
                      elsif @completion_percentage >= 70 && @average_rating < 7
                        "You did well completing your tasks this week, but felt you could have been more productive. You only have five tasks to plan in Volition for a day. Make sure these tasks are the ones that will make you feel like you're making the most progress in your work and life."
                      elsif @completion_percentage < 70 && @average_rating >= 7
                        "It seems like you felt productive this week, but you didn't complete all the tasks you planned to. Try to break your tasks into smaller pieces this upcoming week."
                      elsif @completion_percentage >= 70 && @average_rating >= 7
                        "Great job! You made a solid plan and you stuck to it. Keep up the good work!"
                      end

    reflections = user.reflections.where(created_at: date_args_this_week[:from]..date_args_this_week[:to])
    @wrong = reflections.pluck(:wrong)
    @right = reflections.pluck(:right)

    mail(to: @user.email, subject: "[Volition] Your weekly summary")
  end
end
