class Pawn
	attr_accessor :moveset, :x_position, :y_position, :possible_moves, :icon, :has_moved, :double_stepped, :color

	def initialize(position, is_white)
		@moveset = [
			[0,1],
			[0,2]
			 # still need to include [0,2] if @has_moved is false
		]
		@x_position = position[0]
		@y_position = position[1]
		@possible_moves = []
		@icon = is_white ? "♟" : "♙"
		@has_moved = false
		@double_stepped = false
		@color =  is_white ? "white" : "black"
	end

	def find_possible_moves(positions)
		@moveset.each do |move|
			x = @x_position + move[0]
			y = @y_position + move[1]

			if (0..7).include?(x) 
				if (0..7).include?(y) 
					if positions[x][y] == nil
						@possible_moves << [x, y] # need to be able to move diagonally to capture, and also en passant
					end
					# if the move is one forward, and the space is empty, it can happen
					# if the move is two forward, both the space and the space before it must be empty and the pawn must not have moved before
					# if the move is diagonal, there must be an enemy piece on the diagonal space

				end
			end
		end
	end
end