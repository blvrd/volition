class ChangeWeeklySummaryToOptInOnly < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :weekly_summary, :boolean, default: false
  end
end
