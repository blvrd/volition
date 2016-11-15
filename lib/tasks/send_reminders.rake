namespace :send_reminders do
  task :run do
    SmsRemindersJob.perform_later
  end
end
