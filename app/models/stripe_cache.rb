class StripeCache
  def initialize(user)
    @user = user
  end

  def refresh
    purge_all
    cache_all
    self
  end

  def customer
    return @customer if @customer

    @customer = Rails.cache.fetch(cache_key("customer"), expires_in: 30.minutes) do
      Stripe::Customer.retrieve(user.stripe_customer_id)
    end
  end

  def subscription
    return @subscription if @subscription

    @subscription = Rails.cache.fetch(cache_key("subscription"), expires_in: 30.minutes) do
      Stripe::Subscription.retrieve(user.stripe_subscription_id)
    end
  end

  private

  attr_reader :user

  def purge_all
    Rails.cache.delete_matched("#{user.id}/stripe")
  end

  def cache_all
    customer
    subscription
  end

  def cache_key(item)
    "user/#{user.id}/stripe/#{item}"
  end
end
