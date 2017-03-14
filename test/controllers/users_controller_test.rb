require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include StripeHelper

  setup do
    @user = users(:garrett)
    login_as(@user)

    stub_create_stripe_customer
    stub_retrieve_stripe_customer
    stub_create_stripe_subscription
    stub_create_stripe_source
  end

  test '#create should set timezone' do
    cookies[:timezone] = "America/Chicago"
    post users_path, params: {
      user: {
        email: 'user@example.com',
        password: 'password'
      }
    }

    user = User.last.reload

    assert_not_nil(user.timezone)
    assert_equal('America/Chicago', user.timezone)
  end

  test '#update adding credit card success' do
    @user.update(stripe_customer_id: 'abc123')

    # email is unchanged
    put user_path(@user), params: {
      user: { email: 'garrett@example.com' },
      stripeToken: 'abc123'
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
end
