require_relative "helper.rb"

class Knight
	attr_accessor :moveset, :x_position, :y_position, :icon, :possible_moves, :color

	def initialize(position, is_white)
		@moveset = [
			[-1,-2],
			[-2,-1],
			[-2,+1],
			[-1,+2],
			[+1,-2],
			[+2,-1],
			[+2,+1],
			[+1,+2]
		]
		@x_position = position[0]
		@y_position = position[1]
		@possible_moves = []
		@icon = is_white ? "♞" : "♘"
		@color =  is_white ? "white" : "black"
	end

	def find_possible_moves(positions)
		@moveset.each do |move|
			x = @x_position + move[0]
			y = @y_position + move[1]

			if valid_position?(x,y)
				@possible_moves << [x, y] if positions[x][y] == nil || positions[x][y].color != @color
			end
		end
	end
end