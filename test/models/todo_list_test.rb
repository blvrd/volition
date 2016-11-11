require 'test_helper'

class TodoListTest < ActiveSupport::TestCase
  current_time = DateTime.current.change({ hour: 20 })

  test '.today' do
    user = users(:garrett)

    Time.use_zone('Central Time (US & Canada)') do
      travel_to(current_time) do
        assert(TodoList.today(user) == todo_lists(:today))
      end
    end
  end

  test '.past' do
    user = users(:garrett)

    Time.use_zone('Central Time (US & Canada)') do
      travel_to(current_time) do
        assert(
          TodoList.past(user) == [
            todo_lists(:yesterday),
            todo_lists(:two_days_ago)
          ]
        )
      end
    end
  end

end
