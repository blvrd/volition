class SmsRemindersJob < ApplicationJob
  queue_as :sms_reminders

  def perform
    twilio_client = Twilio::REST::Client.new(
      ENV['TWILIO_SID'],
      ENV['TWILIO_AUTH_TOKEN']
    )

    User.want_sms_reminders.finishing_their_day.each do |user|
      twilio_client.account.messages.create({
        from: ENV['TWILIO_SENDER_PHONE_NUMBER'],
        to: user.phone,
        body: 'Here\'s a reminder from Volition to reflect on your day.'
      })
    end
  rescue => e
    Rails.logger.error(e)
  end
end
