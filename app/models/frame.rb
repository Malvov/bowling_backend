# == Schema Information
#
# Table name: frames
#
#  id            :bigint(8)        not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  game_id       :bigint(8)
#  first_roll    :integer          default(0)
#  second_roll   :integer          default(0)
#  bonus         :integer          default(0)
#  frame_tracker :integer
#

class Frame < ApplicationRecord
    belongs_to :game
    include OrderQuery #in order to get next and previous frames
    
    
    def pins_down(pins)
        
        if self.frame_tracker == 0
            self.update(first_roll: pins)
        elsif self.frame_tracker == 1
            self.update(second_roll: pins)
        end
        set_tracker
    end

    def set_tracker
        update_tracker = self.frame_tracker+1
        self.update(frame_tracker: update_tracker)
    end

    def is_over?
        self.frame_tracker >= 2 || self.first_roll == 10
    end
    
    def frame_score
        self.first_roll + self.second_roll + self.bonus
    end

    def frame_score_without_bonus
        first_roll + second_roll
    end

end
