require_relative "gameboard.rb"

game = GameBoard.new
game.play

=begin
game.place_pieces
game.positions[4][4] = King.new([4,4], true)
game.save
=end