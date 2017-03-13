require 'test_helper'

class CreditCardServiceTest < ActiveSupport::TestCase
  include StripeHelper

  setup do
    @user    = users(:garrett)
    @service = CreditCardService.new(user: @user)

    stub_create_stripe_customer
    stub_retrieve_stripe_customer
    stub_create_stripe_subscription
    stub_retrieve_stripe_subscription
  end

  test '#create_customer success' do
    result = @service.create_customer

    assert_equal(Stripe::Customer, result.class)
    refute_nil(@user.stripe_customer_id)

    # make sure call to method is idempotent

    FakeCustomer = Struct.new(:id)

    Stripe::Customer.stub(:create, FakeCustomer.new('abc123')) do
      new_result = @service.create_customer
      assert_equal(result, new_result)
    end
  end

  test '#create_customer failure' do
    Stripe::Customer.stub(:create, proc { raise StandardError }) do
      result = @service.create_customer

      refute(result)
    end
  end

  test '#create_subscription success' do
    result = @service.create_subscription

    assert_equal(Stripe::Subscription, result.class)

    # make sure call to method is idempotent

    FakeSubscription = Struct.new(:id)

    Stripe::Subscription.stub(:create, FakeSubscription.new('abc123')) do
      new_result = @service.create_subscription
      assert_equal(result, new_result)
    end
  end

  test '#create_subscription failure' do
    Stripe::Subscription.stub(:create, proc { raise StandardError }) do
      result = @service.create_subscription

      refute(result)
    end
  end

  test '#charge success' do

  end

  test '#charge failure' do

  end
end
