require 'test_helper'

class PaymentServiceTest < ActiveSupport::TestCase
  setup do
    @user          = users(:garrett)
    @stripe_helper = StripeMock.create_test_helper

    StripeMock.start
  end

  teardown do
    StripeMock.stop
  end

  test "#charge_card success" do
    PaymentService.charge_card(
      token: @stripe_helper.generate_card_token,
      user: @user
    )

    assert(@user.paid)
  end

  test "#charge_card failure" do
    Stripe::Charge.stub(:create, proc { raise StandardError }) do
      PaymentService.charge_card(
        token: @stripe_helper.generate_card_token,
        user: @user
      )
    end

    refute(@user.paid)
  end
end
