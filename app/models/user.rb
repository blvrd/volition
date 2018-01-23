class User < ApplicationRecord
  has_many :reflections, dependent: :destroy
  has_many :todo_lists, dependent: :destroy
  has_many :daily_todos, through: :todo_lists
  has_many :weekly_todos, through: :todo_lists
  has_many :daily_snapshots, -> { where.not(date: Date.current) }, through: :todo_lists
  has_many :weekly_summaries

  has_secure_password validations: false

  scope :want_weekly_summaries,  -> { where(weekly_summary: true) }
  scope :paid,                   -> { where(paid: true) }

  validates :email, presence: true, unless: -> { self.guest? }
  validates :email, uniqueness: true, unless: -> { self.guest? }
  validates :password_digest, presence: true, unless: :skip_password_validation
  validate  :validate_password

  attr_accessor :skip_password_validation

  # TODO extract timezone logic to concern and convert to scope
  def self.finishing_their_day
    timezones = ActiveSupport::TimeZone.all.map do |tz|
      Time.use_zone(tz) do
        tz.tzinfo.name if Time.current.utc.in_time_zone.hour == 17
      end
    end.compact

    User.where(timezone: timezones)
  end

  def validate_password
    if password.present? && password.length < 10 || password == email
      errors.add(:password, 'is invalid')
    end
  end

  def had_a_great_day?
    reflection = Reflection.today(self)
    tomorrows_todo_list = TodoList.tomorrow(self)

    reflection.present? &&
      reflection.rating == 10 &&
      tomorrows_todo_list.present?
  end

  def recently_signed_up?
    created_at > 30.minutes.ago
  end

  def trialing?
    reflections.count < 2
  end

  def completion_percentage(from:, to:)
    snapshots = DailySnapshot.where(
      created_at: from..to,
      todo_list_id: todo_lists.pluck(:id)
    )

    return 0 if snapshots.blank?

    snapshots.reduce(0) do |sum, snapshot|
      next sum unless snapshot.completion_percentage.is_a?(Integer)
      sum += snapshot.completion_percentage
      sum
    end / snapshots.size
  end

  def average_rating(from:, to:)
    (reflections.where(created_at: from..to).average(:rating) || 0).to_i
  end
end
