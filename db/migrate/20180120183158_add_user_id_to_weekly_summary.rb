class AddUserIdToWeeklySummary < ActiveRecord::Migration[5.1]
  def change
    add_column :weekly_summaries, :user_id, :integer
    add_index :weekly_summaries, :user_id
  end
end
