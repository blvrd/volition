class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :content
      t.boolean :complete, default: false
      t.integer :estimated_time_blocks, default: 0
      t.integer :actual_time_blocks, default: 0

      t.timestamps
    end
  end
end
