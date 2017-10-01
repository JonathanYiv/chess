require_relative "piece.rb"

class Queen < Piece
  def initialize(position, is_white)
    @moveset = [
      [1,1],
      [1,-1],
      [-1,1],
      [-1,-1],
      [0,1],
      [0,-1],
      [1,0],
      [-1,0]
    ]
    @icon = is_white ? "♛" : "♕"
    super
  end
end