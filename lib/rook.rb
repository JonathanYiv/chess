class Rook
	attr_accessor :moveset, :x_position, :y_position, :possible_moves, :icon, :has_moved, :color

	def initialize(position, is_white)
		@moveset = [
			[0,1],
			[0,-1],
			[1,0],
			[-1,0]
		]
		@x_position = position[0]
		@y_position = position[1]
		@possible_moves = []
		@icon = is_white ? "♜" : "♖"
		@has_moved = false
		@color =  is_white ? "white" : "black"
	end

	def find_possible_moves(positions) # still need to implement castling
		@moveset.each do |move|
			x = @x_position + move[0]
			y = @y_position + move[1]
			max_found = false

			until max_found == true
				if (0..7).include?(x)
					if (0..7).include?(y)
						if positions[x][y] != nil
							if positions[x][y].color != @color
								@possible_moves << [x,y]
							end
							max_found = true
						else
							@possible_moves << [x,y]
						end
					else
						max_found = true
					end
				else
					max_found = true
				end
				x = x + move[0]
				y = y + move[1]
			end
		end
	end
end