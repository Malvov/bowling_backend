# == Schema Information
#
# Table name: frames
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  game_id     :bigint(8)
#  first_roll  :integer          default(0)
#  second_roll :integer          default(0)
#  bonus       :integer          default(0)
#  tracker     :integer          default(0)
#

class Frame < ApplicationRecord
    belongs_to :game
    include OrderQuery #in order to get next and previous frames
    
    
    def pins_down(pins)
        
        if tracker == 0
            self.update(first_roll: pins)
        elsif tracker == 1
            self.update(second_roll: pins)
        end
        self.update(tracker: tracker+1)
    end

    def is_over?
        tracker >= 2 || first_roll == 10
    end
    
    def frame_score
        first_roll + second_roll + bonus
    end

    def frame_score_without_bonus
        first_roll + second_roll
    end

end
