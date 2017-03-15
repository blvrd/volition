class CreditCardService
  def initialize(user:)
    @user = user
  end

  def create_customer
    return user.stripe_customer if user.stripe_customer_id.present?

    begin
      customer = Stripe::Customer.create(
        email: user.email
      )
      user.update(stripe_customer_id: customer.id)
      customer
    rescue => e
      false
    end
  end

  def create_subscription(with_trial: true)
    return user.stripe_subscription if user.stripe_subscription_id.present?

    options = {
      customer: user.stripe_customer,
      plan: 'basic'
    }

    unless with_trial
      options.merge({ trial_period_days: 0 })
    end

    begin
      subscription = Stripe::Subscription.create(options)
      user.update(stripe_subscription_id: subscription.id)
      subscription
    rescue => e
      false
    end
  end

  def add_card_to_customer(token:)
    return false unless user.stripe_customer_id.present?

    begin
      card = user.stripe_customer.sources.create({ source: token })
      user.update(paid: true)
      card
    rescue => e
      user.update(paid: false)
      false
    end
  end

  def cancel_subscription
    begin
      user.stripe_subscription.delete
      user.update(paid: false, stripe_subscription_id: nil)
    rescue => e
      @error = e
      false
    end
  end

  private

  attr_reader :user
end
