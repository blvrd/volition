require 'test_helper'

describe DailySnapshot do
  before do
    @user = users(:garrett)
    @daily_todo_list = TodoList.create!(list_type: "daily", user: @user)
    @weekly_todo_list = TodoList.create!(list_type: "weekly", user: @user)

    5.times do |n|
      @daily_todo_list.todos.create!(
        content: "this todo is ##{n+1}",
        estimated_time_blocks: 3,
        actual_time_blocks: 4,
        complete: true
      )
    end

  end

  it ".create_from_todo_list" do
    daily_snapshot = DailySnapshot.create_from_todo_list(@daily_todo_list)

    assert_equal("this todo is #1", daily_snapshot.todos.first.content)
    assert_equal(3, daily_snapshot.todos.first.estimated_time_blocks)
    assert_equal(4, daily_snapshot.todos.first.actual_time_blocks)
    assert_equal(true, daily_snapshot.todos.first.complete)

    error = -> {
      DailySnapshot.create_from_todo_list(@weekly_todo_list)
    }.must_raise(StandardError)

    error.message.must_match(I18n.t("daily_snapshot.weekly_todo_list_error_message"))
  end

  it "#completion_percentage" do
    daily_snapshot = DailySnapshot.create_from_todo_list(@daily_todo_list)

    assert_equal(100, daily_snapshot.completion_percentage)

    Todo.last.update!(complete: false)

    DailySnapshot.destroy_all
    new_daily_snapshot = DailySnapshot.create_from_todo_list(@daily_todo_list)

    assert_equal(80, new_daily_snapshot.completion_percentage)

    Todo.last.update!(content: "")

    DailySnapshot.destroy_all
    another_daily_snapshot = DailySnapshot.create_from_todo_list(@daily_todo_list)

    assert_equal(100, another_daily_snapshot.completion_percentage)
  end
end
