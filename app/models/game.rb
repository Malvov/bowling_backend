# == Schema Information
#
# Table name: games
#
#  id          :bigint(8)        not null, primary key
#  player_name :string
#  final_score :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Game < ApplicationRecord
    has_many :frames
    after_create :set_strike_and_spare

    attr_accessor :strike, :spare

    def throw_ball(pins)
        frame = current_frame
        prev_frame = previous_frame(frame)
        prev_frame_bonus = prev_frame.frame_score unless prev_frame.nil?
        frame.pins_down(pins)
        
        #debugger

        if @strike && frame.is_over?
            prev_frame.update(bonus: prev_frame_bonus + frame.frame_score)
            @strike = false
        end

        if pins == 10
            @strike = true
        end

        if @spare && !@strike
            prev_frame.update(bonus: pins)
            @spare = false
        end

        if frame.frame_score == 10 && !@strike
            @spare = true
        end
                
    end

    def score
        total = 0
        frames.each do |frame|
            total += frame.frame_score
        end
        total
    end

    # def strike
    #     @strike || false
    # end

    # def spare
    #     @spare || false
    # end

    def current_frame
        if frames.empty? || frames.last.is_over?
            frames.create
        end
        frames.last
    end

    def previous_frame(current_frame)
        return nil if current_frame == frames.first
        frames.find(current_frame.id).seek([:id, :asc]).previous
    end

    def set_strike_and_spare
        @spare = false
        @strike = false
    end
end
