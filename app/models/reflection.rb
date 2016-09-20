class Reflection < ApplicationRecord
  belongs_to :user

  validates :rating, presence: true
  validates :wrong,  presence: true
  validates :right,  presence: true
  validates :undone, presence: true

  def todo_list
    user.todo_lists.find_by(date: date)
  end
end
