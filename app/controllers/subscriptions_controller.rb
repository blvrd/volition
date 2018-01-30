class SubscriptionsController < AuthenticatedController
  def destroy
    @subscription = current_user.subscription
    @subscription.cancel!

    Stripe::Subscription.retrieve(@subscription.stripe_id).delete

    redirect_to edit_user_path(current_user)
  end
end
