class RemindersMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    RemindersMailer.send_reminder_to(User.first)
  end
end
