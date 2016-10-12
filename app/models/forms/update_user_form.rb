class UpdateUserForm
  include ActiveModel::Model

  def initialize(user=nil, params=nil)
    @user = user
    @params = params
  end

  attr_reader :user, :params
  attr_accessor(
    :name,
    :email,
    :phone,
    :old_password,
    :password,
    :email_reminders,
    :text_message_reminders
  )


  validates :email, presence: true
  validates :phone, numericality: true
  validate :old_password_authenticated, if: -> { updating_password? }

  def save
    if valid?
      update_user
    end
  end

  private

  def update_user
    if updating_password?
      user.update({
        name: params[:name],
        email: params[:email],
        phone: params[:phone],
        password: params[:password],
        password_confirmation: params[:password],
        email_reminders: params[:email_reminders],
        text_message_reminders: params[:text_message_reminders]
      })
    else
      user.update(params)
    end
  end

  def updating_password?
    old_password && new_password
  end

  def old_password_authenticated
    true if user.authenticate(old_password)
  end
end
