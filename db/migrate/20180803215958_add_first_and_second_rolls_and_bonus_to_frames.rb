class AddFirstAndSecondRollsAndBonusToFrames < ActiveRecord::Migration[5.2]
  def change
    add_column :frames, :first_roll, :integer, default: 0
    add_column :frames, :second_roll, :integer, default: 0
    add_column :frames, :bonus, :integer, default: 0
  end
end
