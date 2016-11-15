require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @user = users(:garrett)

    def current_user
      @user
    end

    travel_to(Date.current.end_of_week)
  end

  teardown do
    travel_back
  end

  test '#today_is_trackable? false' do
    @user.update(track_weekends: false)

    refute(today_is_trackable?)
  end

  test '#today_is_trackable? true' do
    @user.update(track_weekends: true)

    assert(today_is_trackable?)
  end
end
