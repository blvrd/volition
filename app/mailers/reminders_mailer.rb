class RemindersMailer < ApplicationMailer
  default from: 'reminders@usevolition.com'

  def send_reminder_to(user)
    @user = user
    mail(
      to: @user.email,
      subject: '[Volition] Reminder to reflect'
    )
  end
end
