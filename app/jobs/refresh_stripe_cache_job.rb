class RefreshStripeCacheJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)

    if user
      StripeCache.new(user).refresh
    end
  end
end
