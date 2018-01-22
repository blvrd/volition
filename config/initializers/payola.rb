StripeEvent.signing_secret = ENV['STRIPE_WEBHOOK_SECRET']

Payola.configure do |config|
  # Example subscription:
  # 
  # config.subscribe 'payola.package.sale.finished' do |sale|
  #   EmailSender.send_an_email(sale.email)
  # end
  # 
  # In addition to any event that Stripe sends, you can subscribe
  # to the following special payola events:
  #
  #  - payola.<sellable class>.sale.finished
  #  - payola.<sellable class>.sale.refunded
  #  - payola.<sellable class>.sale.failed
  #
  # These events consume a Payola::Sale, not a Stripe::Event
  #
  # Example charge verifier:
  #
  # config.charge_verifier = lambda do |sale|
  #   raise "Nope!" if sale.email.includes?('yahoo.com')
  # end

  # Keep this subscription unless you want to disable refund handling
  config.subscribe "invoice.payment_failed" do |event|
    @subscription = Subscription.find_by(stripe_customer_id: event.data.customer_id)

    if @subscription
      @subscription.cancel!
    end
  end

  config.subscribe "invoice.upcoming" do |event|
    @subscription = Subscription.find_by(stripe_customer_id: event.data.customer_id)

    if @subscription
      PaymentsMailer.invoice_upcoming(@subscription)
    end
  end
end
