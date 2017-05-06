class DestroyGuestUsersJob < ApplicationJob
  queue_as :destroy_guest_users

  def perform
    User.where(guest: true).each do |user|
      user.destroy
    end
  end
end
