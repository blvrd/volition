class CreateWeeklySummaries < ActiveRecord::Migration[5.1]
  def change
    create_table :weekly_summaries do |t|
      t.integer :completion_percentage, default: 0
      t.integer :weekly_rating, default: 0
      t.text :todo_list_ids, array: true, default: []

      t.timestamps
    end
  end
end
