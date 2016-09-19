class Reflection < ApplicationRecord
  belongs_to :user

  def todo_list
    user.todo_lists.find_by(date: date)
  end
end
