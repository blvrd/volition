class User < ApplicationRecord
  has_many :reflections, dependent: :destroy
  has_many :todo_lists, dependent: :destroy
  has_many :todos, through: :todo_lists

  has_secure_password

  scope :want_sms_reminders,   -> { where(sms_reminders: true)   }
  scope :want_email_reminders, -> { where(email_reminders: true) }

  validates :phone, presence: true, if: -> { self.sms_reminders? }
  validates :email, presence: true, unless: -> { self.guest? }

  before_create :create_stripe_customer

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

  private

  def create_stripe_customer
    customer = Stripe::Customer.create(
      email: self.email
    )

    self.stripe_customer_id = customer.id
  end
end
