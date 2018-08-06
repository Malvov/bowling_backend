class AddFrameTrackerToFrames < ActiveRecord::Migration[5.2]
  def change
    add_column :frames, :frame_tracker, :integer, default: 0
  end
end
