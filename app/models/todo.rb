class Todo < ApplicationRecord
  belongs_to :todo_list

  default_scope { order(id: :asc) }

  scope :frontend_info, -> { select(:actual_time_blocks, :complete, :content, :id) }
end
