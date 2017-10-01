require_relative '../board.rb'
require_relative 'piece.rb'

# Creates the Knight Piece with its unique moveset,
# moveset calculation algorithm, and icon
class Knight < Piece
  def initialize(position, is_white)
    @moveset = [
      [-1, -2],
      [-2, -1],
      [-2, +1],
      [-1, +2],
      [+1, -2],
      [+2, -1],
      [+2, +1],
      [+1, +2]
    ]
    @icon = is_white ? '♞' : '♘'
    super
  end

  def find_possible_moves(positions)
    @possible_moves = []

    @moveset.each do |move|
      x = @x + move[0]
      y = @y + move[1]

      if Board.includes?(x, y)
        @possible_moves << [x, y] if positions[x][y].nil? || positions[x][y].color != @color
      end
    end
  end
end
