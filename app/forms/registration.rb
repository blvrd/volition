class Registration
  include ActiveModel::Model

  attr_accessor *%i(
    name
    email
    password
    user
    params
  )

  delegate :errors, to: :user

  def initialize(params = {}, user = User.new)
    @params = params
    @user   = user
  end

  def save
    if signing_up_with_google?
      @user.skip_password_validation = true
      google_identity = GoogleSignIn::Identity.new(params[:google_id_token])
      google_id = google_identity.user_id
      email = google_identity.email_address
      name = google_identity.name

      @user.assign_attributes({
        name: name,
        email: email,
        google_id: google_id
      })
    else
      @user.assign_attributes(params)
    end

    @user.guest = false
    @user.timezone = Time.zone.tzinfo.name

    @user.save
  end

  private

  def signing_up_with_google?
    params[:google_id_token].present?
  end
end
