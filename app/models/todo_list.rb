class TodoList < ApplicationRecord
  extend Enumerize

  has_many :todos, dependent: :delete_all

  belongs_to :user
  belongs_to :week_plan, class_name: 'TodoList', required: false

  accepts_nested_attributes_for :todos,
                                reject_if: :all_blank

  self.per_page = 5

  enumerize :list_type, in: %w(daily weekly)

  scope :weekly, -> { where(list_type: 'weekly') }
  scope :daily,  -> { where(list_type: 'daily') }

  def weekly?
    list_type == 'weekly'
  end

  def daily?
    list_type == 'daily'
  end

  def self.today(user)
    find_by(list_type: 'daily', date: Date.current, user_id: user.id)
  end

  def self.tomorrow(user)
    find_by(date: Date.current.next_day, user_id: user.id)
  end

  def self.past(user)
    where('date < ? and user_id = ?', Date.current, user.id).order(date: :desc)
  end

  def reflection
    user.reflections.find_by(date: date)
  end
end
