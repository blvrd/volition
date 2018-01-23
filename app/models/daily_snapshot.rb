class DailySnapshot < ApplicationRecord
  belongs_to :todo_list

  serialize :data, DataStructSerializer

  delegate :reflection, to: :todo_list

  validates :todo_list, uniqueness: true

  scope :today, -> { where(date: Date.current.beginning_of_day..Time.current) }

  def todos
    data.todos
  end

  def self.create_from_todo_list(todo_list)
    unless todo_list.daily?
      raise StandardError, I18n.t("daily_snapshot.weekly_todo_list_error_message")
    end

    columns_to_select = %w(
      content
      estimated_time_blocks
      actual_time_blocks
      complete
    )

    create!(
      todo_list_id: todo_list.id,
      date: todo_list.date,
      data: { todos: Todo.select(columns_to_select)
                .where(daily_todo_list_id: todo_list.id)
                .as_json(except: :id) }
    )
  end

  def completion_percentage
    return 0 unless todos.present?
    todos_filled_out = todos.select { |todo| todo.content.present? }
    return 0 unless todos_filled_out.present?

    (todos_filled_out.select { |todo| todo.complete  }.count / todos_filled_out.count.to_f) * 100
  end
end
