require_relative "helper.rb"

class Bishop
	attr_accessor :moveset, :x_position, :y_position, :icon, :possible_moves, :color

	def initialize(position, is_white)
		@moveset = [
			[1,1],
			[1,-1],
			[-1,1],
			[-1,-1]
		]
		@x_position = position[0]
		@y_position = position[1]
		@possible_moves = []
		@icon = is_white ? "♝" : "♗"
		@color =  is_white ? "white" : "black"
	end

	def find_possible_moves(positions)
		@possible_moves = []

		@moveset.each do |move|
			x, y = @x_position + move[0], @y_position + move[1]
			max_found = false

			until max_found == true
				if valid_position?(x,y)
					if !positions[x][y].nil?
						@possible_moves << [x,y] if positions[x][y].color != @color
						max_found = true
					else
						@possible_moves << [x,y]
					end
				else
					max_found = true
				end
				x += move[0]
				y += move[1]
			end
		end
	end
end




=begin




@moveset.each do |move|
			x, y = @x_position + move[0], @y_position + move[1]


			if valid_position?(x, y)
				loop do
					binding.pry
					@possible_moves << [x, y] if positions[x][y].nil?
					@possible_moves << [x, y] if positions[x][y]&.color != @color
					exit if !positions[x][y].nil?
					x += move[0]
					y += move[1]
				end
			end
		end

=end