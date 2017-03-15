class UsersController < AuthenticatedController
  skip_before_action :authenticate_user!, only: [:new, :create]
  skip_before_action :ensure_user_paid!

  before_action :set_user

  def new
    if current_user.present? && !current_user.guest?
      redirect_to dashboard_path
    end
    @user = User.new
  end

  def create
    if current_user
      @user = current_user
      @user.assign_attributes(user_params)
      @user.guest = false
    else
      @user = User.new(user_params)
    end

    @user.password_confirmation = user_params[:password]
    @user.timezone = Time.zone.tzinfo.name

    valid = @user.save && create_customer_and_subscription

    if valid
      login(@user)
      redirect_to welcome_path
    else
      render :new
    end
  end

  def edit
    if @user.stripe_customer
      @existing_card = current_user.stripe_customer.sources.first
    end
  end

  def update
    @user.assign_attributes(user_params)

    valid = @user.save && add_card_to_user

    if valid
      flash[:success] = 'Settings updated'
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      redirect_to settings_path
    end
  end

  def cancel_subscription
    @credit_card_service = CreditCardService.new(user: @user)

    if @credit_card_service.cancel_subscription
      flash[:success] = 'Subscription cancelled.'
    else
      flash[:error] = 'Something went wrong.'
    end

    redirect_to settings_path
  end

  private

  def create_customer_and_subscription
    @credit_card_service = CreditCardService.new(user: @user)

    @credit_card_service.create_customer &&
      @credit_card_service.create_subscription
  end

  def add_card_to_user
    @credit_card_service = CreditCardService.new(user: @user)

    if params[:stripeToken]
      @credit_card_service.add_card_to_customer(token: params[:stripeToken])
    else
      true
    end
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :phone,
      :email_reminders,
      :sms_reminders,
      :track_weekends,
      :password
    )
  end
end
