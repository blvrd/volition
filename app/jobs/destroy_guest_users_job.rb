class DestroyGuestUsersJob < ApplicationJob
  queue_as :destroy_guest_users

  def perform
    User.where('guest = true and created_at < ?', 1.hour.ago).each do |user|
      user.destroy
    end
  end
end
