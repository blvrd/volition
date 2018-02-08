class RemoveReminderColumnsFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :email_reminders, :boolean
    remove_column :users, :sms_reminders, :boolean
    remove_column :users, :phone, :string
  end
end
