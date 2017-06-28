require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:garrett)
    @stripe_helper = StripeMock.create_test_helper

    login_as(@user)
    StripeMock.start
    @stripe_helper.create_plan(id: 'basic', amount: 100, trial_period_days: 30)
  end

  teardown do
    StripeMock.stop
  end

  test '#create should set timezone' do
    cookies[:timezone] = "America/Chicago"
    post users_path, params: {
      user: {
        email: 'user@example.com',
        password: SecureRandom.hex
      }
    }

    user = User.last.reload

    assert_not_nil(user.timezone)
    assert_equal('America/Chicago', user.timezone)
  end

  test '#update adding credit card success' do
    customer = Stripe::Customer.create
    @user.update(stripe_customer_id: customer.id)
    token = @stripe_helper.generate_card_token

    # email is unchanged
    put user_path(@user), params: {
      user: { email: 'garrett@example.com' },
      stripeToken: token
    }

    assert_redirected_to(dashboard_path)
  end

  test '#update adding credit card failure' do
    Stripe::ListObject.stub_any_instance(:create, proc { raise StandardError }) do
      put user_path(@user), params: {
        user: { email: 'garrett@example.com' },
        stripeToken: 'abc123'
      }

      assert_redirected_to(settings_path)
    end
  end

  test '#create sets stripe ids' do
    logout

    post users_path, params: {
      user: {
        email: 'me@g.com',
        name: 'G',
        password: SecureRandom.hex
      }
    }

    user = User.last

    assert_redirected_to(welcome_path)
    assert(user.stripe_customer_id)
    assert(user.stripe_subscription_id)
  end

  test '#destroy should cancel subscription and destroy user' do
    customer = Stripe::Customer.create
    subscription = Stripe::Subscription.create(plan: 'basic', customer: customer.id)
    @user.update(stripe_subscription_id: subscription.id, stripe_customer_id: customer.id)

    delete user_path(@user)

    refute(User.exists?(@user.id))
    # refute(Stripe::Subscription.retrieve(subscription.id))
    assert_redirected_to(new_user_path)
  end

  test '#cancel_subscription' do
    customer = Stripe::Customer.create
    subscription = Stripe::Subscription.create(plan: 'basic', customer: customer.id)
    @user.update(stripe_subscription_id: subscription.id, stripe_customer_id: customer.id)

    delete cancel_subscription_user_path(@user)

    refute(@user.reload.stripe_subscription_id)
  end
end
