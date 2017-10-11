namespace :send_weekly_summaries do
  task run: :environment do
    if Date.current.sunday?
      User.paid.want_weekly_summaries.find_each do |user|
        WeeklySummaryMailer.weekly_summary(user).deliver_later
      end
    end
  end
end
