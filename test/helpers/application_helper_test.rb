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

  test '#tomorrow_is_trackable? false' do
    travel_to(Date.current.end_of_week - 2)
    @user.update(track_weekends: false)

    refute(tomorrow_is_trackable?)
  end

  test '#tomorrow_is_trackable? true' do
    travel_to(Date.current.end_of_week - 2)
    @user.update(track_weekends: true)

    assert(tomorrow_is_trackable?)

    travel_to(Date.current.end_of_week)
    @user.update(track_weekends: false)

    assert(tomorrow_is_trackable?)
  end

   test 'truncate(user_agent: :desktop)' do
     truncated_string = truncate('This is a long todo. I should do this by the end of the day', user_agent: :desktop)
     assert_equal('This is a long todo. I should do this...', truncated_string)
   end

   test 'truncate(user_agent: :mobile)' do
     truncated_string = truncate('This is a long todo. I should do this by the end of the day', user_agent: :mobile)
     assert_equal('This is a long todo. I...', truncated_string)
   end

   test 'self_hosted? true' do
     ENV['SELF_HOSTED'] = 'true'

     assert_equal(true, self_hosted?)
   end

   test 'self_hosted? false' do
     ENV['SELF_HOSTED'] = 'false'

     assert_equal(false, self_hosted?)
   end
end
