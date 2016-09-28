class Reflection < ApplicationRecord
  belongs_to :user

  validates :rating, presence: true
  validates :wrong,  presence: true
  validates :right,  presence: true
  validates :undone, presence: true

  def self.today(user)
    find_by(date: Time.current.to_date.beginning_of_day, user_id: user.id)
  end

  def todo_list
    user.todo_lists.find_by(date: date)
  end
end
