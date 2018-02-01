class CreateStripeGiftSubscriptionJob < ApplicationJob
  queue_as :create_gift_subscription

  def perform(gift)
    recipient = gift.recipient

    stripe_customer = Stripe::Customer.create(
      { email: recipient.email },
      # { idempotency_key: gift.unique_token }
    )

    plan = SubscriptionPlan.find_by(name: "Yearly")

    stripe_subscription = Stripe::Subscription.create(
      customer: stripe_customer.id,
      items: [{ plan: "yearly" }],
      coupon: "gift_yearly"
    )

    payola_subscription = Payola::Subscription.create!(
      plan: plan,
      email: recipient.email,
      currency: "usd",
      owner: recipient,
      coupon: "gift_yearly",
      stripe_customer_id: stripe_customer.id,
      stripe_id: stripe_subscription.id
    )

    payola_subscription.sync_with!(stripe_subscription)
    payola_subscription.update(state: "active", coupon: "gift_yearly")
  end
end
