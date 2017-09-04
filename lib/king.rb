require_relative "helper.rb"

class King
	attr_accessor :moveset, :x_position, :y_position, :possible_moves, :icon, :has_moved, :color

	def initialize(position, is_white)
		@moveset = [
			[1,1],
			[1,0],
			[1,-1],
			[0,1],
			[0,-1],
			[-1,1],
			[-1,0],
			[-1,-1],
		]
		@x_position = position[0]
		@y_position = position[1]
		@possible_moves = []
		@icon = is_white ? "♚" : "♔"
		@has_moved = false
		@color =  is_white ? "white" : "black"
	end

	def find_possible_moves(positions)
		@moveset.each do |move|
			x = @x_position + move[0]
			y = @y_position + move[1]

			test_positions = Array.new(8) { Array.new(8, nil) }
			positions.each_with_index do |row, row_index|
				row.each_with_index do |column, column_index|
					test_positions[row_index][column_index] = positions[row_index][column_index].nil? ? nil : positions[row_index][column_index].clone
				end
			end

			test_positions[@x_position][@y_position] = nil
			test_knight = King.new([x, y], @color == "white")
			test_positions[x][y] = test_knight

			test_positions.flatten.each do |piece|
				piece.find_possible_moves(test_positions) if piece != nil && piece.color != @color
			end

			@possible_moves << [x, y] if !test_knight.in_check?(test_positions) && (positions[x][y].nil? || positions[x][y].color != @color)
			
		end
	end

	def in_check?(positions)
		in_check = false
		positions.flatten.each do |piece|
			if piece.instance_of? Pawn
				piece.possible_moves.each do |move|
					in_check = true if move[1] != piece.y_position && move == [@x_position, @y_position]
				end
			else
				in_check = true if !piece.nil? && piece.possible_moves.include?([@x_position, @y_position]) 
			end
		end

		in_check
	end
end