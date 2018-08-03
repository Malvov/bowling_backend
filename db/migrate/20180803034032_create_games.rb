class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :player_name
      t.integer :final_score, default: 0
      t.boolean :is_over, default: false
      t.timestamps
    end
  end
end
