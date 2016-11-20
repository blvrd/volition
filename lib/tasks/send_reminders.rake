namespace :send_reminders do
  task run: :environment do
    SmsRemindersJob.perform_later
    EmailRemindersJob.perform_later
  end
end
