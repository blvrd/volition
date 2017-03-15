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
    stub_delete_stripe_subscription
    stub_create_stripe_source
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

  test '#add_card_to_customer success' do
    @user.update(paid: false)
    @service.create_customer

    result = @service.add_card_to_customer(token: 'abc123')

    assert_equal(Stripe::Card, result.class)
    assert(@user.paid?)
  end

  test '#add_card_to_customer failure' do
    @service.create_customer

    Stripe::ListObject.stub_any_instance(:create, proc { raise StandardError }) do
      result = @service.add_card_to_customer(token: 'abc123')

      refute(result)
      refute(@user.paid?)
    end
  end

  test '#cancel subscription success' do
    @service.create_subscription
    @service.cancel_subscription

    refute(@user.paid?)
    assert_nil(@user.stripe_subscription_id)
  end

  test '#cancel subscription failure' do
    @service.create_subscription

    Stripe::Subscription.stub_any_instance(:delete, proc { raise StandardError }) do
      @service.cancel_subscription

      assert(@user.paid?)
      refute_nil(@user.stripe_subscription_id)
    end
  end
end
