class King
	attr_accessor :moveset, :x_position, :y_position, :possible_moves, :icon, :has_moved, :color

	def initialize(position, is_white)
		@moveset = [
			[1,1],
			[1,0],
			[1,-1],
			[0,1],
			[0,-1],
			[-1,1],
			[-1,0],
			[-1,-1],
		]
		@x_position = position[0]
		@y_position = position[1]
		@possible_moves = []
		@icon = is_white ? "♚" : "♔"
		@has_moved = false
		@color =  is_white ? "white" : "black"
	end

	def find_possible_moves(positions) # still need to implement castling
		@moveset.each do |move|
			x = @x_position + move[0]
			y = @y_position + move[1]

			if (0..7).include?(x) 
				if (0..7).include?(y) 
					if positions[x][y] == nil || positions[x][y].color != @color
						illegal_move = false
						positions.each do |row|
							row.each do |piece|
								if piece != nil
									if piece.color != @color && piece.possible_moves.include?([x, y])
										illegal_move = true
									end
								end
							end
						end
						@possible_moves << [x, y] if illegal_move == false
					end
				end
			end
		end
	end
end