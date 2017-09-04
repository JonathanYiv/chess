require_relative "helper.rb"

class Pawn
	attr_accessor :moveset, :x_position, :y_position, :possible_moves, :icon, :has_moved, :double_stepped, :color

	def initialize(position, is_white)
		@moveset = {
			one_step: [1, 0],
			double_step: [2, 0],
			right_diagonal: [1, 1],
			left_diagonal: [1, -1],
		}
		@x_position = position[0]
		@y_position = position[1]
		@possible_moves = []
		@icon = is_white ? "♟" : "♙"
		@has_moved = false
		@double_stepped = false
		@color =  is_white ? "white" : "black"
		@moveset.keys.each { |move_type| @moveset[move_type][0] *= -1} if @color == "white"
	end

	def find_possible_moves(positions) 
		@moveset.keys.each do |move_type|
			x = @x_position + @moveset[move_type][0]
			y = @y_position + @moveset[move_type][1]

			case move_type
			when :one_step
				@possible_moves << [x, y] if positions[x][y].nil?
			when :double_step
				@possible_moves << [x, y] if positions[x][y].nil? && positions[(x + @x_position) / 2][y].nil? && @has_moved == false
			when :right_diagonal, :left_diagonal
				@possible_moves << [x, y] if !positions[x][y].nil? && positions[x][y].color != @color
			end

		end
	end
end