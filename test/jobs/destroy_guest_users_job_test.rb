require 'test_helper'

class DestroyGuestUsersJobTest < ActiveJob::TestCase
  test 'does not destroy recent guest users' do
    user = User.create(
      email: 'me@example.com',
      password: SecureRandom.hex,
      guest: true
    )

    DestroyGuestUsersJob.perform_now

    assert(User.exists?(user.id))

    Timecop.freeze(5.hours.from_now) do
      DestroyGuestUsersJob.perform_now

      refute(User.exists?(user.id))
    end
  end
end
