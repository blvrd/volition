class AddWeeklySummaryEmailToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :weekly_summary, :boolean, default: true
  end
end
