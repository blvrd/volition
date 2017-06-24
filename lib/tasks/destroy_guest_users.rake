namespace :destroy_guest_users do
  task run: :environment do
    DestroyGuestUsersJob.perform_later
  end
end
