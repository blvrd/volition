class Reflection < ApplicationRecord
  belongs_to :user

  validates :rating, presence: true
  validates :negative,  presence: true
  validates :positive,  presence: true

  def self.today(user)
    find_by(date: Date.current, user_id: user.id)
  end

  def todo_list
    user.todo_lists.find_by(date: date)
  end
end
