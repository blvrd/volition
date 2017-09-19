module PaymentService
  def self.charge_card(token:, user:)
    begin
      charge = Stripe::Charge.create(
        amount: 1200,
        currency: "usd",
        source: token,
        description: "Full access, forever.",
        receipt_email: user.email
      )
      if charge.status == "succeeded"
        user.update(
          paid: true,
          stripe_charge_id: charge.id
        )
      end
    rescue => e
      false
    end
  end
end
