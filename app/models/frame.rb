# == Schema Information
#
# Table name: frames
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  is_over     :boolean          default(FALSE)
#  game_id     :bigint(8)
#  first_roll  :integer          default(0)
#  second_roll :integer          default(0)
#  bonus       :integer          default(0)
#

class Frame < ApplicationRecord
    belongs_to :game
    include OrderQuery #in order to get next and previous frames
    
    attr_accessor :frame_tracker
    def pins_down(pins)
        debugger
        if frame_tracker.to_i == 0
            if pins == 10 || frame_tracker.to_i > 2
                self.toggle(:is_over)
            end
            self.update(first_roll: pins)
        elsif frame_tracker == 1 || 
            self.update(second_roll: pins)
            self.toggle(:is_over)
        end

        @frame_tracker = 1
        # pins_left = PIN_COUNT - pins

        # if pins_left == 0
        #     self.toggle(:is_over)
        #     self.update(first_roll: pins)
        # elsif pins_left < 10 && !is_over?
        #     self.update(first_roll: pins)
        # else
        # end     
    end
    
    def frame_score
        first_roll + second_roll + bonus
    end

end
