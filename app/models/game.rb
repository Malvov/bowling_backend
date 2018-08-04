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
    
    attr_accessor :strike, :spare, :frame_tracker

    

    def ball_throw(pins)
        frame = current_frame
        prev_frame = previous_frame(frame)
        frame.pins_down(pins)

        if @strike && frame.is_over?
            prev_frame.bonus = frame.frame_score unless !prev_frame.nil?
            @strike = false
        end

        if pins == 10
            @strike = true
        end

        if @spare
            prev_frame.bonus = pins
            @spare = false
        end

        if frame.frame_score == 10
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

    def strike
        @strike || false
    end

    def spare
        @spare || false
    end

    def current_frame
        if frames.empty? || frames.last.is_over?
            frames.create
        end

        frames.last
    end

    def previous_frame(current_frame)
        nil if current_frame == frames.first
        frames.find(current_frame.id).seek([:id, :asc]).previous
    end
end
