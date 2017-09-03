require_relative "gameboard.rb"

game = GameBoard.new
#game.play
game.update_possible_moves
puts game.positions[7][4].possible_moves.inspect
game.display