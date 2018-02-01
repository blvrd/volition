class GiftsController < ApplicationController
  def new
    @gift = Gift.new
    gon.stripe_public_key = ENV['STRIPE_PUBLIC_KEY']
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.sender = current_user

    unless @gift.save
      gon.stripe_public_key = ENV['STRIPE_PUBLIC_KEY']
      return render :new
    end

    begin
      charge_args = {
        amount: 5_000,
        currency: "usd",
        description: "Gift Yearly Subscription from #{current_user.email}"
      }

      payment_method = if current_user.active?
                         {
                           customer: current_user.subscription
                                                 .stripe_customer_id
                         }
                       else
                         { source: params[:stripeToken] }
                       end

      charge_args.merge!(payment_method)

      charge = Stripe::Charge.create(charge_args)
    rescue => e
      @gift.destroy
      flash.now[:error] = "Something went wrong. Please check you card details and try again."
      return render :new
    end

    @gift.update(stripe_charge_id: charge.id)

    GiftsMailer.gift_notification(@gift).deliver_later

    flash[:success] = "You sent #{@gift.recipient_name} a yearly subscription!"
    redirect_to settings_path
  end

  private

  def gift_params
    params.require(:gift).permit(:recipient_email, :recipient_name, :message)
  end
end
