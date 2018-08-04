class AddTrackerToFrames < ActiveRecord::Migration[5.2]
  def change
    add_column :frames, :tracker, :integer, default: 0
  end
end
