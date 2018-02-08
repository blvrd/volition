namespace :create_daily_snapshots do
  task run: :environment do
    CreateDailySnapshotsJob.perform_later
  end
end
