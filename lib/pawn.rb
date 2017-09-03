require_relative "helper.rb"

class Pawn
	attr_accessor :moveset, :x_position, :y_position, :possible_moves, :icon, :has_moved, :double_stepped, :color

	def initialize(position, is_white)
		@moveset = [
			[0,1]
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
		x = @x_position + move[0]
		y = @y_position + move[1]

		if valid_position?(x,y) # one space forward
			@possible_moves << [x,y] if positions[x][y] == nil
		end

		if @has_moved == false # two spaces forward
			if positions[@x_position][@y_position + 1] == nil && positions[@x_position][@y_position + 2] == nil
				@possible_moves << [@x_position, @y_position + 2]
			end
		end

		if positions[@x_position - 1][@y_position + 1] != nil && positions[@x_position - 1][@y_position + 1].color != @color # left diagonal capture
			@possible_moves << [@x_position - 1, @y_position + 1]
		end

		if positions[@x_position + 1][@y_position + 1] != nil && positions[@x_position + 1][@y_position + 1].color != @color # right diagonal capture
			@possible_moves << [@x_position + 1, @y_position + 1]
		end
	end
end