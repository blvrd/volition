Stripe.api_key                    = ENV['STRIPE_SECRET_KEY']
StripeEvent.authentication_secret = ENV['STRIPE_WEBHOOK_SECRET']

StripeEvent.configure do |events|
  events.all do |event|
    Rails.logger.info event.data
  end

  events.subscribe 'customer.subscription.trial_will_end' do |event|
    user = User.find_by(stripe_customer_id: event.data.object.customer)

    PaymentsMailer.send_trial_ending_to(user)
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
