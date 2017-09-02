class King
	attr_accessor :moveset, :x_position, :y_position, :possible_moves, :icon, :has_moved

	def initialize(position, is_white)
		@moveset = [
			# pending..
		]
		@x_position = position[0]
		@y_position = position[1]
		@possible_moves = find_possible_moves
		@icon = is_white ? "♚" : "♔"
		@has_moved = false
	end

	def find_possible_moves
		# pending..
	end
end

=begin
Chess Board
0,0 0,1 0,2 0,3 0,4 0,5 0,6 0,7
1,0 1X1 1,2 1X3 1,4 1,5 1,6 1,7
2X0 2,1 2,2 2,3 2X4 2,5 2,6 2,7
3,0 3,1 3@2 3,3 3,4 3,5 3,6 3,7
4X0 4,1 4,2 4,3 4X4 4,5 4,6 4,7
5,0 5X1 5,2 5X3 5,4 5,5 5,6 5,7
6,0 6,1 6,2 6,3 6,4 6,5 6,6 6,7
7,0 7,1 7,2 7,3 7,4 7,5 7,6 7,7
=end