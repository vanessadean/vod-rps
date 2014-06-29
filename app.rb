require_relative 'config/environment'

class GameApp < Sinatra::Base
  get '/' do
    redirect '/rps/rock'
  end

  get '/rps/:play' do
    begin
      game = RPSGame.new(params[:play])
      @your_move = params[:play]
      @computer_move = game.computer_play

      if game.dynamite?
        redirect '/boom'
      elsif game.won?
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

  get '/boom' do
    "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0'>
  <script src='https://raw.github.com/wilto/iOS-orientationchange-fix.js'></script><link rel='stylesheet' href='http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css'><style>body {
            background: url(\"http://cdn29.elitedaily.com/wp-content/uploads/2014/06/wikia11.gif\");
            background-size: cover;
            background-repeat: repeat-n;
        }</style></head>"
  end

end