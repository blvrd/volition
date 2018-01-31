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

  def referral_activated(referred_user)
    @referred_user = referred_user
    @referrer      = referred_user.referrer

    mail(
      to: @referrer.email,
      subject: "[Volition] Someone used your referral link!"
    )
  end
end
