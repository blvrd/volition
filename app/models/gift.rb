# Purchased and sent to someone that doesn't currently subscribed to Volition
# When a user signs up through the unique gift link, a discounted Stripe
# subscription is created.

class Gift < ApplicationRecord
  with_options class_name: "User" do
    belongs_to :recipient, required: false
    belongs_to :sender
  end

  has_secure_token :unique_token

  validates :recipient_email, presence: true
  validates :recipient_name, presence: true
  validates :message, presence: true
end
