class GamesController < ApplicationController
    before_action :set_game, only: [:show]
    
    def index
        @games = Game.all

        render json: @games
    end

    def create

    end

    def show
        
    end

    private

    def set_game
        @game = Game.find(params[:id])
    end
    def game_params
        params.require(:game).permit(:player_name, :final_score, :is_over)
    end
end
