class TodoList < ApplicationRecord
  has_many :todos

  belongs_to :user

  def reflection
    user.reflections.find_by(date: date)
  end
end
