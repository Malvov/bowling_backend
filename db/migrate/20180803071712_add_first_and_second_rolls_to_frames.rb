class AddFirstAndSecondRollsToFrames < ActiveRecord::Migration[5.2]
  def change
    add_column :frames, :first_roll, :integer
    add_column :frames, :second_roll, :integer
  end
end
