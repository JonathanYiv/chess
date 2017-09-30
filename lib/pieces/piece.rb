require_relative "../board.rb"

class Piece
	attr_accessor :moveset, :x_position, :y_position, :icon, :possible_moves, :color

	def initialize(position, is_white) 
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

			loop do
				break if Board.includes?(x, y) == false
				@possible_moves << [x, y] if positions[x][y].nil? || positions[x][y].color != @color
				break if !positions[x][y].nil?
				x += move[0]
				y += move[1]
			end
		end
	end
end