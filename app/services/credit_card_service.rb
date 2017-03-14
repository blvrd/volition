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

  def create_subscription
    return user.stripe_subscription if user.stripe_subscription_id.present?

    begin
      subscription = Stripe::Subscription.create(
        customer: user.stripe_customer,
        plan: 'basic'
      )
      user.update(stripe_subscription_id: subscription.id)
      subscription
    rescue => e
      false
    end
  end

  def add_card_to_customer(token:)
    return nil unless user.stripe_customer_id.present?

    begin
      user.stripe_customer.sources.create({ source: token })
    rescue => e
      false
    end
  end

  private

  attr_reader :user
end
