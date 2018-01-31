class PaymentsController < ApplicationController
  before_action :ensure_not_paid!, only: [:new, :create]

  def new
    @monthly_plan         = SubscriptionPlan.find_by(name: "Monthly")
    @yearly_plan          = SubscriptionPlan.find_by(name: "Yearly")
    @subscription         = current_user.subscription

    gon.stripe_public_key = ENV['STRIPE_PUBLIC_KEY']
    gon.monthly_plan_id   = @monthly_plan.id
    gon.yearly_plan_id    = @yearly_plan.id
  end

  def create
    plan = SubscriptionPlan.find_by(id: params[:plan_id])

    subscription = Payola::Subscription.create(
      plan: plan,
      email: current_user.email,
      stripe_token: params[:stripeToken],
      currency: "usd",
      owner: current_user,
      amount: plan.amount
    )

    subscription.process!

    if subscription.active?
      activate_referral if current_user.referrer.present?
      redirect_to thank_you_path
    else
      flash[:error] = %(
        Something went wrong. Please check your card details and try again
      )

      subscription.destroy

      redirect_to new_payment_path
    end
  end

  def edit
    gon.stripe_public_key = ENV['STRIPE_PUBLIC_KEY']
    @subscription = current_user.subscription
  end

  def update
    @subscription    = current_user.subscription
    @customer        = Stripe::Customer.retrieve(@subscription.stripe_customer_id)
    @customer.source = params[:stripeToken]

    @customer.save

    source = @customer.sources.first

    @subscription.update(
      stripe_token: params[:stripeToken],
      card_last4: source.last4,
      card_expiration: Date.new(source.exp_year, source.exp_month, 1)
    )

    flash[:success] = "Updated billing info"
    redirect_to settings_path
  end

  private

  def activate_referral
    referrer        = current_user.referrer
    subscription_id = referrer.subscription.stripe_id
    coupon_name     = if referrer.subscription.name == "Monthly"
                        "referral_credit_monthly"
                      else
                        "referral_credit_yearly"
                      end

    stripe_subscription = Stripe::Subscription.retrieve(subscription_id)
    stripe_subscription.coupon = coupon_name
    stripe_subscription.save

    PaymentsMailer.referral_activated(current_user).deliver_later
  end

  def ensure_not_paid!
    redirect_to settings_path if current_user.active?
  end
end
