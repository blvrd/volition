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
    rescue
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
    rescue
      false
    end
  end

  private

  attr_reader :user
end
