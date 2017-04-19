class PaymentsMailer < ApplicationMailer
  default from: 'payments@usevolition.com'

  def send_trial_ending_to(user)
    @user = user
    @subscription_end_date = Date.strptime(user.stripe_subscription.trial_end.to_s, '%s')

    mail(
      to: @user.email,
      subject: '[Volition] Your trial is ending soon!'
    )
  end
end
