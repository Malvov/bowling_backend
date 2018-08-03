# == Schema Information
#
# Table name: frames
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  is_over     :boolean          default(FALSE)
#  first_roll  :integer
#  second_roll :integer
#

class Frame < ApplicationRecord
    include OrderQuery
    
    attr_accessor :frame_tracker

    def add(pins)
        if frame_tracker == 0
            if pins == 10
                self.is_over = true
            end
            self.first_roll =  pins
        elsif frame_tracker == 1 || !self.is_over?
            self.second_roll = pins
        end
        @frame_tracker += 1
    end

    def frame_tracker
        @frame_tracker || 0
    end

end
