require_relative 'config/environment'
require 'pry'

class GameApp < Sinatra::Base
  get '/rps/:play' do
    begin
    game = RPSGame.new(params[:play])
    rescue PlayTypeError
      @result = "Invalid move!"
    end
    @your_move = params[:play]
    @computer_move = game.computer_play

    if game.won?
      @result = "You won!"
    elsif game.lost?
      @result = "You lost!"
    elsif game.tied?
      @result = "You tied!"
    end

    erb :rps_game
  end
end