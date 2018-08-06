# == Schema Information
#
# Table name: games
#
#  id          :bigint(8)        not null, primary key
#  player_name :string
#  final_score :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  is_over     :boolean          default(FALSE)
#

class Game < ApplicationRecord
    has_many :frames
    after_create :initialize_variables

    attr_accessor :strike, :spare, :frame_counter

    def throw_ball(pins)
        
        frame = current_frame
        prev_frame = previous_frame(frame)
        prev_frame_bonus = prev_frame.frame_score unless prev_frame.nil?
        frame.pins_down(pins)
        

        if @strike && frame.is_over? && @frame_counter < 10 #things get pretty weird in the tenth
            prev_frame.update(bonus: frame.frame_score + prev_frame_bonus)
            @strike = false
        end

        if pins == 10
            @strike = true
        end

        if @spare && !@strike && @frame_counter  < 10
            @spare = false
            prev_frame.update(bonus: pins) unless prev_frame.nil?
        end


        if (frame.second_roll <= 10 && (frame.first_roll != 0 && frame.second_roll != 0) ) && frame.is_over? && self.frames.count < 10
            @spare = true
        end
        
        @frame_counter = frames.count
                
    end

    def score
        total = 0
        self.frames.each do |frame|
            total += frame.frame_score
        end
        total
    end

    def current_frame
        if self.frames.empty? || self.frames.last.is_over?
            self.frames.create
        end
        self.frames.last
    end

    def previous_frame(current_frame)
        return nil if current_frame == self.frames.first
        self.frames.find(current_frame.id).seek([:id, :asc]).previous
    end

    def initialize_variables
        @spare = @strike = false
        @frame_counter = 1
    end

end
