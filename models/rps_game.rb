class RPSGame
  attr_reader   :move

  def initialize(move)
    @move = move.to_sym
    @computer = [:rock, :paper, :scissors].sample
    raise PlayTypeError unless self.class.valid_play?(@move) 
  end

  def self.valid_play?(move)
    [:rock, :paper, :scissors].include?(move)
  end

  def computer_play
    @computer
  end

  def won?
    defeat = {:rock => :scissors, :paper => :rock, :scissors => :paper}
    defeat[self.move] == self.computer_play
  end

  def tied?
    self.move == self.computer_play
  end

  def lost?    
    !won? && !tied?
  end
end

class PlayTypeError < StandardError

end