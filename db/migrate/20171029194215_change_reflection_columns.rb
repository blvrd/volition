class ChangeReflectionColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :reflections, :wrong, :negative
    rename_column :reflections, :right, :positive
    remove_column :reflections, :undone
  end
end
