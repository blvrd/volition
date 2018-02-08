class WeeklySummary < ApplicationRecord
  belongs_to :user

  def todo_lists
    TodoList.where(id: todo_list_ids)
  end

  def daily_snapshots
    DailySnapshot.where(todo_list_id: todo_list_ids)
  end

  def reflections
    todo_lists.map(&:reflection).compact
  end

  def previous_weekly_summary
    (user.weekly_summaries.where.not(id: id)).last
  end

  def generate_stats
    weekly_todos = daily_snapshots.flat_map(&:todos)
    complete_todos = weekly_todos.select(&:complete)
    self.completion_percentage = (complete_todos.count / weekly_todos.count.to_f) * 100

    if reflections.present?
      self.weekly_rating = reflections.map(&:rating).reduce(0, :+) / reflections.count
    else
      self.weekly_rating = 0
    end
  end

  def arrow_and_class(sym)
    begin
      if send(sym) > previous_weekly_summary.send(sym)
        ["&#9650;", "better"]
      elsif send(sym) < previous_weekly_summary.send(sym)
        ["&#9660;", "worse"]
      else
        ["&minus;", ""]
      end
    rescue
      ["&minus;", ""]
    end
  end

  def recommendation
    if completion_percentage < 70 && weekly_rating < 7
      "It looks like you didn't get everything done this past week and that reflected on how productive you thought your days were. Try being more deliberate in planning your tasks this coming week in order to build momentum."
    elsif completion_percentage >= 70 && weekly_rating < 7
      "You did well completing your tasks this week, but felt you could have been more productive. You only have five tasks to plan in Volition for a day. Make sure these tasks are the ones that will make you feel like you're making the most progress in your work and life."
    elsif completion_percentage < 70 && weekly_rating >= 7
      "It seems like you felt productive this week, but you didn't complete all the tasks you planned to. Try to break your tasks into smaller pieces this upcoming week."
    elsif completion_percentage >= 70 && weekly_rating >= 7
      "Great job! You made a solid plan and you stuck to it. Keep up the good work!"
    end
  end
end
