class AddDateToDailySnapshot < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_snapshots, :date, :date
  end
end
