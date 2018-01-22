class Todo < ApplicationRecord
  with_options class_name: 'TodoList', required: false do |options|
    options.belongs_to :daily_todo_list, foreign_key: 'daily_todo_list_id'
    options.belongs_to :weekly_todo_list, foreign_key: 'weekly_todo_list_id'
  end

  default_scope { order(id: :asc) }

  validates :content, presence: true, if: -> { weekly_todo_list.present? }

  scope :complete, -> { where(complete: true) }
  scope :incomplete, -> { where(complete: false).where.not(content: "") }
  scope :for_todo_list, -> (todo_list_id) {
    ids = find_by_sql %(
      select id from todos
      where daily_todo_list_id = #{todo_list_id}
      or weekly_todo_list_id = #{todo_list_id};
    ).squish

    where(id: ids)
  }

  scope :frontend_info, -> {
    select(:actual_time_blocks,
           :estimated_time_blocks,
           :complete,
           :content,
           :id)
  }

end
