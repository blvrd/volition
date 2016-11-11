require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:garrett)
  end

  test '#had_a_great_day? returns false' do
    reflection = Reflection.create(
      rating: 6,
      wrong: 'Took too many breaks today.',
      right: 'Finished most of my tasks.',
      undone: 'Some things.',
      date: Date.current,
      user: @user
    )

    assert(@user.had_a_great_day? == false)
  end

  test '#had_a_great_day? returns true' do
    reflection = Reflection.create(
      rating: 10,
      wrong: 'Nothing!',
      right: 'Finished all of my tasks.',
      undone: 'Nothing.',
      date: Date.current,
      user: @user
    )

    assert(@user.had_a_great_day? == true)
  end

  test '#recently_signed_up? returns true' do
    travel_to(1.day.from_now) do
      assert(@user.recently_signed_up? == false)
    end
  end

  test '#recently_signed_up? returns false' do
    assert(@user.recently_signed_up? == true)
  end
end
