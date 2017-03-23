require 'test_helper'

class StripeEventsTest < ActionDispatch::IntegrationTest
  def stub_event(fixture_id, status: 200)
    stub_request(:get, "https://api.stripe.com/v1/events/#{fixture_id}").
      to_return(status: status, body: File.read("test/support/api_responses/#{fixture_id}.json"))
  end

  test 'charge.succeeded' do
    stub_event('stripe_charge_succeeded')
    user = users(:garrett)
    user.update(
      paid: false,
      stripe_customer_id: 'cus_00000000000000'
    )

    post '/stripe-events', params: { id: 'stripe_charge_succeeded' }

    assert(user.reload.paid?)
  end

  test 'charge.failed' do
    stub_event('stripe_charge_failed')
    user = users(:garrett)
    user.update(
      stripe_customer_id: 'cus_00000000000000'
    )

    post '/stripe-events', params: { id: 'stripe_charge_failed' }

    refute(user.reload.paid?)
  end
end
