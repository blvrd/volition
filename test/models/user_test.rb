require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:garrett)
  end

  test '#had_a_great_day? returns false' do
    reflection = Reflection.create(
      rating: 6,
      negative: 'Took too many breaks today.',
      positive: 'Finished most of my tasks.',
      date: Date.current,
      user: @user
    )

    assert(@user.had_a_great_day? == false)
  end

  test '#had_a_great_day? returns true' do
    reflection = Reflection.create(
      rating: 10,
      negative: 'Nothing!',
      positive: 'Finished all of my tasks.',
      date: Date.current,
      user: @user
    )

    assert(@user.had_a_great_day? == true)
  end

  test '#recently_signed_up? returns false' do
    travel_to(1.day.from_now) do
      assert(@user.recently_signed_up? == false)
    end
  end

  test '#recently_signed_up? returns true' do
    assert(@user.recently_signed_up? == true)
  end

  test '.finishing_their_day' do
    chicago_time_zone = ActiveSupport::TimeZone.all.find {|zone| zone.tzinfo.name == 'America/Chicago'}


    @user.update(timezone: 'America/Chicago')

    new_user = User.create(
      email: 'new@example.com',
      password: 'password',
      password_confirmation: 'password',
      timezone: 'America/New_York'
    )

    travel_to(Time.utc(2016, 11, 10, 23, 0, 0)) do
      assert_includes(User.finishing_their_day, @user)
      refute_includes(User.finishing_their_day, new_user)
    end
  end

  test '#trialing?' do
    assert(@user.trialing?)

    @user.reflections.build.save(validate: false)

    assert(@user.trialing?)

    @user.reflections.build.save(validate: false)

    refute(@user.trialing?)
  end

  test '#average_rating' do
    assert_equal(0, @user.average_rating(from: 6.days.ago, to: Date.current.end_of_day))

    @user.reflections.create!(
      rating: 1,
      negative: "Nothing",
      positive: "Nothing",
    )

    assert_equal(1, @user.average_rating(from: 6.days.ago, to: Date.current.end_of_day))

    @user.reflections.create!(
      rating: 10,
      negative: "Nothing",
      positive: "Nothing",
    )

    assert_equal(5, @user.average_rating(from: 6.days.ago, to: Date.current.end_of_day))
  end
end
