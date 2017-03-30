class PaymentService
  def initialize(params = nil)
    @params = params
  end

  def create_customer
    begin
      Stripe::Customer.create(
        email: params[:email]
      )
    rescue => e
      false
    end
  end

  def create_subscription(with_trial: true)
    options = {
      customer: params[:stripe_customer_id],
      plan: 'basic'
    }

    unless with_trial
      options.merge({ trial_period_days: 0 })
    end

    begin
      Stripe::Subscription.create(options)
    rescue => e
      false
    end
  end

  def add_card_to_customer(token:)
    begin
      customer = Stripe::Customer.retrieve(params[:stripe_customer_id])
      customer.sources.create({ source: token })
    rescue => e
      false
    end
  end

  def cancel_subscription
    begin
      Stripe::Subscription.retrieve(params[:stripe_subscription_id]).delete
    rescue => e
      false
    end
  end

  private

  attr_reader :params
end
