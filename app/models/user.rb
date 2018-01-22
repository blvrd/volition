class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :reflections, dependent: :destroy
  has_many :todo_lists, dependent: :destroy
  has_many :daily_todos, through: :todo_lists
  has_many :weekly_todos, through: :todo_lists
  has_many :daily_snapshots, -> { where.not(date: Date.current) }, through: :todo_lists
  has_many :weekly_summaries

  with_options class_name: "User", foreign_key: :referred_by do
    has_many :referred_users

    belongs_to :referrer, optional: true
  end

  has_one :subscription,
          foreign_key: "owner_id",
          class_name: "Payola::Subscription"

  delegate :active?, to: :subscription

  def subscription
    super || NullSubscription.new
  end

  has_secure_password validations: false
  has_secure_token :referral_code

  scope :want_weekly_summaries, -> { where(weekly_summary: true) }
  scope :paid, -> { where(paid: true) }

  validates :email, presence: true, unless: -> { self.guest? }
  validates :email, uniqueness: true, unless: -> { self.guest? }
  validates :password_digest, presence: true, unless: :skip_password_validation
  # validate :validate_password

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
    reflections.count < 2 || in_referral_month?
  end

  def in_referral_month?
    return false unless referred_by.present?

    Date.current < (created_at + 1.month)
  end

  def completion_percentage(from:, to:)
    snapshots = DailySnapshot.where(
      created_at: from..to,
      todo_list_id: todo_lists.pluck(:id),
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

  def forgot_password!
    update(
      password_reset_token: SecureRandom.hex,
      password_reset_token_expiration: Time.current + 2.hours
    )
  end

  def eligible_for_password_reset
    password_reset_token_expiration > Time.current
  end

  def referral_link
    new_user_url(referral_code: referral_code, host: ENV["APPLICATION_HOST"])
  end
end
