class User < ApplicationRecord
  has_many :reflections, dependent: :destroy
  has_many :todo_lists, dependent: :destroy
  has_many :todos, through: :todo_lists

  has_secure_password

  scope :want_sms_reminders,   -> { where(sms_reminders: true)   }
  scope :want_email_reminders, -> { where(email_reminders: true) }

  validates :phone, presence: true, if: -> { self.sms_reminders? }
  validates :email, presence: true, unless: -> { self.guest? }
  validates :email, uniqueness: true

  # TODO extract timezone logic to concern and convert to scope
  def self.finishing_their_day
    timezones = ActiveSupport::TimeZone.all.map do |tz|
      Time.use_zone(tz) do
        tz.tzinfo.name if Time.current.utc.in_time_zone.hour == 17
      end
    end.compact

    User.where(timezone: timezones)
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

  def stripe_customer
    return nil if stripe_customer_id.blank?

    stripe_customer = $redis.get('stripe_customer')

    unless stripe_customer.present?
      $redis.set('stripe_customer', Stripe::Customer.retrieve(stripe_customer_id))
    end

    JSON.parse($redis.get('stripe_customer'), object_class: OpenStruct)
  end

  def stripe_subscription
    return nil if stripe_subscription_id.blank?

    stripe_subscription = $redis.get('stripe_subscription')

    unless stripe_subscription.present?
      $redis.set('stripe_subscription', Stripe::Subscription.retrieve(stripe_subscription_id))
    end

    JSON.parse($redis.get('stripe_subscription'), object_class: OpenStruct)
  end

  def trialing?
    stripe_subscription.status == 'trialing'
  end

  def trial_days_left
    return 0 unless trialing?

    trial_end = Time.at(stripe_subscription.trial_end).to_date

    (trial_end - Date.current).to_i
  end

  def can_cancel_subscription?
    !trialing? && paid
  end
end
