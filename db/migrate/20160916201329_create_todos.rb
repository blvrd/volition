class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :content
      t.boolean :complete
      t.integer :estimated_time_blocks
      t.integer :actual_time_blocks

      t.timestamps
    end
  end
end
