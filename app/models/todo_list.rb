class TodoList < ApplicationRecord
  extend Enumerize

  before_destroy :delete_todos

  with_options class_name: 'Todo', dependent: :destroy do |options|
    options.has_many :daily_todos, foreign_key: :daily_todo_list_id
    options.has_many :weekly_todos, foreign_key: :weekly_todo_list_id
  end

  def todos
    daily_todos.or(weekly_todos)
  end

  belongs_to :user
  belongs_to :week_plan, class_name: 'TodoList', required: false

  has_one :daily_snapshot, dependent: :destroy

  accepts_nested_attributes_for :daily_todos,
                                reject_if: :all_blank

  accepts_nested_attributes_for :weekly_todos,
                                reject_if: :all_blank


  self.per_page = 5

  enumerize :list_type, in: %w(daily weekly)

  scope :weekly, -> { where(list_type: 'weekly') }
  scope :daily,  -> { where(list_type: 'daily') }
  scope :missing_snapshot, -> {
    daily.left_outer_joins(:daily_snapshot)
         .where(daily_snapshots: { id: nil })
  }

  def delete_todos
    todos.delete_all
  end

  def weekly?
    list_type == 'weekly'
  end

  def daily?
    list_type == 'daily'
  end

  def self.today(user)
    find_by(
      date: Date.current,
      user_id: user.id,
      list_type: "daily"
    )
  end

  def self.tomorrow(user)
    find_by(
      date: Date.current.next_day,
      user_id: user.id,
      list_type: "daily"
    )
  end

  def self.past(user)
    where(
      'date < ? and user_id = ?',
      Date.current,
      user.id
    ).order(date: :desc)
  end

  def reflection
    user.reflections.find_by(date: date)
  end
end
