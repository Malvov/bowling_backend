class AddIsOverToFrames < ActiveRecord::Migration[5.2]
  def change
    add_column :frames, :is_over, :boolean, default: :false
  end
end
