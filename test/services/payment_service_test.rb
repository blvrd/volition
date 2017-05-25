require 'test_helper'

class PaymentServiceTest < ActiveSupport::TestCase
  setup do
    @user          = users(:garrett)
    @stripe_helper = StripeMock.create_test_helper

    StripeMock.start
    @stripe_helper.create_plan(id: 'basic', amount: 100)
  end

  teardown do
    StripeMock.stop
  end

  test '#create_customer success' do
    service = PaymentService.new({ email: 'email@example.com' })
    result = service.create_customer

    assert_equal(Stripe::Customer, result.class)
  end

  test '#create_customer failure' do
    service = PaymentService.new({ email: 'email@example.com' })
    Stripe::Customer.stub(:create, proc { raise StandardError }) do
      result = service.create_customer

      refute(result)
    end
  end

  test '#create_subscription success' do
    customer = Stripe::Customer.create(source: @stripe_helper.generate_card_token)
    service = PaymentService.new({ stripe_customer_id: customer.id })
    result = service.create_subscription

    assert_equal(Stripe::Subscription, result.class)
  end

  test '#create_subscription failure' do
    service = PaymentService.new({ email: 'email@example.com' })
    Stripe::Subscription.stub(:create, proc { raise StandardError }) do
      result = service.create_subscription

      refute(result)
    end
  end

  test '#add_card_to_customer success' do
    customer = Stripe::Customer.create
    token = @stripe_helper.generate_card_token
    service = PaymentService.new({ email: 'email@example.com', stripe_customer_id: customer.id })

    result = service.add_card_to_customer(token: token)

    assert_equal(Stripe::Card, result.class)
  end

  test '#add_card_to_customer failure' do
    customer = Stripe::Customer.create
    service = PaymentService.new({ email: 'email@example.com', stripe_customer_id: customer.id })

    Stripe::ListObject.stub_any_instance(:create, proc { raise StandardError }) do
      result = service.add_card_to_customer(token: 'abc123')

      refute(result)
    end
  end

  test '#cancel subscription success' do
    customer = Stripe::Customer.create(source: @stripe_helper.generate_card_token)
    subscription = Stripe::Subscription.create(plan: 'basic', customer: customer.id)
    service = PaymentService.new({ email: 'email@example.com', stripe_subscription_id: subscription.id })
    result = service.cancel_subscription

    assert_equal(Stripe::Subscription, result.class)
  end

  test '#cancel subscription failure' do
    customer = Stripe::Customer.create(source: @stripe_helper.generate_card_token)
    subscription = Stripe::Subscription.create(plan: 'basic', customer: customer.id)
    service = PaymentService.new({ email: 'email@example.com', stripe_subscription_id: subscription.id })

    Stripe::Subscription.stub_any_instance(:delete, proc { raise StandardError }) do
      service.cancel_subscription

    end
  end
end
