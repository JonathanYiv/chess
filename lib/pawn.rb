require_relative "helper.rb"

class Pawn
	attr_accessor :moveset, :x_position, :y_position, :possible_moves, :icon, :has_moved, :double_stepped, :color

	def initialize(position, is_white)
		@moveset = [
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
		move = color == "white" ? -1 : +1
		x = @x_position + move
		y = @y_position 

		@possible_moves << [x,y] if positions[x][y] == nil && valid_position?(x,y)

		if @has_moved == false
			if positions[x][y] == nil && positions[x + move][y] == nil
				@possible_moves << [x + move, y]
			end
		end

		x = @x_position

		if positions[x - move][y + move] != nil && positions[x - move][y + move].color != @color
			@possible_moves << [x - move, y + move]
		end

		if positions[x + move][y + move] != nil && positions[x + move][y + move].color != @color
			@possible_moves << [x + move, y + move]
		end
	end
end

=begin
WHITE
[1,0]
[2,0] if it hasn't moved yet and both [1,0] and [2,0] are empty
[1,1]
[1,-1]

BLACK
[-1,0]
[-2,0] if it hasn't moved yet and both [-1,0] and [-2,0] are empty
[-1,1]
[-1,-1]
=end