require 'test_helper'

class StripeCacheTest < ActiveSupport::TestCase
  setup do
    Rails.cache.clear
    @stripe_helper = StripeMock.create_test_helper
    StripeMock.start
    @stripe_helper.create_plan(id: 'basic', amount: 100)
    customer = Stripe::Customer.create(source: @stripe_helper.generate_card_token)
    subscription = Stripe::Subscription.create(customer: customer, plan: 'basic')

    @user = users(:garrett)
    @user.update(stripe_customer_id: customer.id, stripe_subscription_id: subscription.id)
    @stripe_cache = StripeCache.new(@user)
  end

  test '#refresh' do
    assert_nil(Rails.cache.fetch(@stripe_cache.send(:cache_key, 'customer')))
    assert_nil(Rails.cache.fetch(@stripe_cache.send(:cache_key, 'subscription')))

    @stripe_cache.refresh

    cached_customer     = Rails.cache.fetch(@stripe_cache.send(:cache_key, 'customer'))
    cached_subscription = Rails.cache.fetch(@stripe_cache.send(:cache_key, 'subscription'))

    refute_nil(cached_subscription)
    refute_nil(cached_customer)
  end

  test '#customer' do
    assert_nil(Rails.cache.fetch(@stripe_cache.send(:cache_key, 'customer')))

    customer = @stripe_cache.customer

    assert_equal(customer, Rails.cache.fetch(@stripe_cache.send(:cache_key, 'customer')))
  end

  test '#subscription' do
    assert_nil(Rails.cache.fetch(@stripe_cache.send(:cache_key, 'subscription')))

    subscription = @stripe_cache.subscription

    cached_subscription = Rails.cache.fetch(@stripe_cache.send(:cache_key, 'subscription'))

    refute_nil(cached_subscription)
    assert_equal(subscription, cached_subscription)
  end
end
