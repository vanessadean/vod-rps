require_relative 'config/environment'

class GameApp < Sinatra::Base
  get '/rps/:play' do
    begin
    game = RPSGame.new(params[:play])
    @your_move = params[:play]
    @computer_move = game.computer_play

    if game.won?
      @result = "<p style='color:#5cb85c'>You won!</style>"
    elsif game.lost?
      @result = "<p style='color:#d9534f'>You lost.</style>"
    elsif game.tied?
      @result = "You tied."
    end

    rescue PlayTypeError
      @result = "Invalid move!"
    end

    erb :rps_game
  end
end