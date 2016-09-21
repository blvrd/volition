class TodoList < ApplicationRecord
  has_many :todos, dependent: :delete_all

  belongs_to :user

  accepts_nested_attributes_for :todos,
                                reject_if: :all_blank

  def self.today(user)
    find_by(date: Date.today, user_id: user.id)
  end

  def self.tomorrow(user)
    find_by(date: Date.today.next_day, user_id: user.id)
  end

  def self.past(user)
    where('date < ? and user_id = ?', Date.today, user.id).order(date: :desc)
  end

  def reflection
    user.reflections.find_by(date: date)
  end
end
