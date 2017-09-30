class PaymentsController < ApplicationController
  before_action :ensure_not_paid!

  def new
    gon.stripe_public_key = ENV['STRIPE_PUBLIC_KEY']
  end

  def create
    valid = PaymentService.charge_card(
      token: params[:stripeToken],
      user: current_user
    )

    if valid
      redirect_to thank_you_path
    else
      flash[:error] = %(
        Something went wrong. Please check you card details and try again
      )

      redirect_to new_payment_path
    end
  end

  private

  def ensure_not_paid!
    redirect_to settings_path if current_user.paid?
  end
end
