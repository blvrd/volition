class PaymentsMailer < ApplicationMailer
  default from: 'payments@usevolition.com'

  def invoice_upcoming(subscription)
    @subscription = subscription
    @user = @subscription.owner

    mail(
      to: @user.email,
      subject: "[Volition] You card will be charged soon"
    )
  end
end
