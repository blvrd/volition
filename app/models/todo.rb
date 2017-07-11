class Todo < ApplicationRecord
  belongs_to :todo_list

  default_scope { order(id: :asc) }

  validates :content, presence: true, if: -> { todo_list.weekly? }

  scope :frontend_info, -> {
    select(:actual_time_blocks,
           :estimated_time_blocks,
           :complete,
           :content,
           :id)
  }
end
