require 'test_helper'

class WeeklySummaryTest < ActiveSupport::TestCase
  test "#generate_stats" do
    weekly_summary = WeeklySummary.create(todo_list_ids: TodoList.pluck(:id))
    TodoList.first.todos.create(content: "Homework", complete: true)
    CreateDailySnapshotsJob.perform_now

    weekly_summary.generate_stats

    assert_equal(50, weekly_summary.completion_percentage)
  end
end
