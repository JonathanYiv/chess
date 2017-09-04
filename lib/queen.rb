require_relative "helper.rb"

class Queen
	attr_accessor :moveset, :x_position, :y_position, :icon, :possible_moves, :color

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
		@x_position = position[0]
		@y_position = position[1]
		@possible_moves = []
		@icon = is_white ? "♛" : "♕"
		@color =  is_white ? "white" : "black"
	end

	def find_possible_moves(positions)
		@possible_moves = []
		
		@moveset.each do |move|
			x = @x_position + move[0]
			y = @y_position + move[1]
			max_found = false

			until max_found == true
				if valid_position?(x,y)
					if positions[x][y] != nil
						@possible_moves << [x,y] if positions[x][y].color != @color
						max_found = true
					else
						@possible_moves << [x,y]
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