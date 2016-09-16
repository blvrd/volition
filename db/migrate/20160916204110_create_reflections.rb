class CreateReflections < ActiveRecord::Migration[5.0]
  def change
    create_table :reflections do |t|
      t.integer :rating
      t.text :wrong
      t.text :right
      t.text :undone
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
