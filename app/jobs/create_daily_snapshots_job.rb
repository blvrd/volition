class CreateDailySnapshotsJob < ApplicationJob
  queue_as :daily_snapshots

  def perform
    TodoList.missing_snapshot.find_each do |todo_list|
      DailySnapshot.create_from_todo_list(todo_list)
    end
  end
end
