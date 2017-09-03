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

		if valid_position?(x,y)
			@possible_moves << [x,y] if positions[x][y] == nil
		end

		if @has_moved == false
			if positions[@x_position + move][@y_position] == nil && positions[@x_position + 2 * move][@y_position] == nil
				@possible_moves << [@x_position + 2 * move, @y_position]
			end
		end

		if positions[@x_position - move][@y_position + move] != nil && positions[@x_position - move][@y_position + move].color != @color
			@possible_moves << [@x_position - move, @y_position + move]
		end

		if positions[@x_position + move][@y_position + move] != nil && positions[@x_position + move][@y_position + move].color != @color
			@possible_moves << [@x_position + move, @y_position + move]
		end
	end
end