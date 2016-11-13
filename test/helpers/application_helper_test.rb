require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @user = users(:garrett)

    def current_user
      @user
    end

    travel_to(Date.current.end_of_week)
  end

  test '#today_is_trackable? false' do
    assert_not(today_is_trackable?)
  end

  test '#today_is_trackable? true' do
    @user.update(track_weekends: true)

    assert(today_is_trackable?)
  end
end
