Stripe.api_key = ENV['STRIPE_SECRET_KEY']

StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.trial_will_end' do |event|
    # email user that trial ending soon
  end

  events.subscribe 'charge.succeeded' do |event|
    user = User.find_by(stripe_customer_id: event.data.object.source.customer)

    if user
      user.update(paid: true)
    end
  end

  events.subscribe 'charge.failed' do |event|
    user = User.find_by(stripe_customer_id: event.data.object.source.customer)

    if user
      user.update(paid: false)
    end
  end
end
