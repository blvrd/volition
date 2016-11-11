class AddSettingsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email_notifications, :boolean, default: false
    add_column :users, :sms_notifications, :boolean, default: false
    add_column :users, :track_weekends, :boolean, default: true
  end
end
