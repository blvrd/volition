class EmailRemindersJob < ApplicationJob
  queue_as :email_reminders

  def perform
    User.want_email_reminders.finishing_their_day.each do |user|
      RemindersMailer.send_reminder_to(user).deliver
    end
  rescue => e
    Rails.logger.error(e)
  end
end
