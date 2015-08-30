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
    gif = ['http://i.giphy.com/Ylm2VS0fB9jDq.gif','http://i.giphy.com/IE1hr4AcZn9pS.gif','http://i.giphy.com/rKTH5ov06VfH2.gif','http://i.giphy.com/FFuJMaDOb8SxW.gif','http://i.giphy.com/KpP3MLwPMhqgw.gif'].sample
    "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0'><link rel='stylesheet' href='http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css'><style>body {
            background: url(#{gif});
            background-size: cover;
            background-repeat: repeat-n;
        }</style></head>"
  end
end