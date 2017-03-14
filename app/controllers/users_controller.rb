class UsersController < AuthenticatedController
  skip_before_action :authenticate_user!, only: [:new, :create]
  skip_before_action :ensure_user_paid!, only: [:new, :create, :edit]

  if Rails.env == 'production'
    http_basic_authenticate_with name: ENV['HTTP_AUTH_USERNAME'], password: ENV['HTTP_AUTH_PASSWORD']
  end

  def new
    if current_user.present?
      redirect_to dashboard_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
    @user = current_user
    if @user.stripe_customer
      @existing_card = @user.stripe_customer.sources.first
    end
  end

  def update
    @user = current_user
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
