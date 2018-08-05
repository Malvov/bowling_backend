class GamesController < ApplicationController
    before_action :set_game, only: [:show]
    
    def index
        @games = Game.all
        
        render json: @games
    end

    def create
        @game = Game.new(game_params)
        if @game.save
            render json: @game, status: :created, location: @game
        else
            render json: game.errors, status: :unprocessable_entity
        end
    end

    def show
        @game_with_frames = {
            game: @game,
            frames: @game.frames.order('id asc')
        }
        render json: @game_with_frames
    end

    private

    def set_game
        @game = Game.find(params[:id])
    end
    def game_params
        params.require(:game).permit(:player_name, :final_score, :is_over)
    end
end
