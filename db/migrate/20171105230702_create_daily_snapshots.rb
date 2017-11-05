class CreateDailySnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_snapshots do |t|
      t.jsonb :data, default: "{}"
      t.references :todo_list, foreign_key: true

      t.timestamps
    end
  end
end
