require_relative "../board.rb"

class Pawn < Piece
	attr_accessor :has_moved, :double_stepped

	def initialize(position, is_white)
		@moveset = {
			one_step: [1, 0],
			double_step: [2, 0],
			right_diagonal: [1, 1],
			left_diagonal: [1, -1],
		}
		@has_moved = false
		@double_stepped = false
		@icon = is_white ? "♟" : "♙"
		super
		@moveset.keys.each { |move_type| @moveset[move_type][0] *= -1} if @color == "white"
	end

	def find_possible_moves(positions) 
		@possible_moves = []
		
		@moveset.keys.each do |move_type|
			x = @x + @moveset[move_type][0]
			y = @y + @moveset[move_type][1]

			if Board.includes?(x, y)
				case move_type
				when :one_step
					@possible_moves << [x, y] if positions[x][y].nil?
				when :double_step
					@possible_moves << [x, y] if positions[x][y].nil? && positions[(x + @x) / 2][y].nil? && @has_moved == false
				when :right_diagonal, :left_diagonal
					@possible_moves << [x, y] if !positions[x][y].nil? && positions[x][y].color != @color
					add_en_passant(positions, x, y)
				end
			end
		end
	end

	def add_en_passant(positions, x, y)
		if positions[x][y].nil?
			if @color == "white"
				if positions[x + 1][y].instance_of?(Pawn) && positions[x + 1][y].double_stepped == true
					@possible_moves << [x, y]
				end
			end

			if @color == "black"
				if positions[x - 1][y].instance_of?(Pawn) && positions[x - 1][y].double_stepped = true
					@possible_moves << [x, y]
				end
			end
		end
	end
end