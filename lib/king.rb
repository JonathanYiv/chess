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
		@possible_moves = []

		@moveset.each do |move|
			x = @x_position + move[0]
			y = @y_position + move[1]

			if valid_position?(x, y)

				test_positions = Array.new(8) { Array.new(8, nil) }
				positions.each_with_index do |row, row_index|
					row.each_with_index do |column, column_index|
						test_positions[row_index][column_index] = positions[row_index][column_index].nil? ? nil : positions[row_index][column_index].clone
					end
				end

				test_positions[@x_position][@y_position] = nil
				test_knight = King.new([x, y], @color == "white")
				test_positions[x][y] = test_knight

				

				test_positions.flatten.select { |square| square !=  nil && square.color != color }.each do |piece| 
					if piece.instance_of?(King)
						piece.moveset.each do |test_move|
							a = piece.x_position + test_move[0]
							b = piece.y_position + test_move[1]

							if valid_position?(a, b)
								piece.possible_moves << [a, b] # this right here is causing the issue
							end
						end
					else
						piece.find_possible_moves(test_positions)
					end
				end

				# king was somehow able to eat the queen of same color
				@possible_moves << [x, y] if !test_knight.in_check?(test_positions) && (positions[x][y].nil? || positions[x][y].color != @color)
			end
		end
	end

	def in_check?(positions)
		in_check = false
		positions.flatten.select { |piece| !piece.nil? && piece.color != @color }.each do |piece| #each do |piece|
			if piece.instance_of? Pawn
				piece.possible_moves.each do |move|
					in_check = true if move[1] != piece.y_position && move == [@x_position, @y_position]
				end
			else
				in_check = true if piece.possible_moves.include?([@x_position, @y_position]) 
			end
		end

		in_check
	end
end



=begin
enemy_king = nil

test_positions.flatten.each do |piece|
	piece.find_possible_moves(test_positions) if piece != nil && piece.color != @color && !(piece.instance_of? King)
	enemy_king = piece if piece.instance_of?(King) && piece.color != @color
end

enemy_king.moveset.each do |move|
	a = enemy_king.x_position + move[0]
	b = enemy_king.y_position + move[1]

	if valid_position?(a, b)
		enemy_king.possible_moves << [a, b]
	end
end

test_positions.flatten.each do |piece|
	if piece != nil && piece.color != @color
		if piece.instance_of?(King)
			piece.moveset.each do |move|
				a = piece.x_position + move[0]
				b = piece.y_position + move[1]

				if valid_position?(a, b)
					piece.possible_moves << [a, b]
				end
			end
		else
			piece.find_possible_moves(test_positions)
		end
	end
end

test_positions.flatten.select { |square| square !=  nil && square.color != color }.each do |piece|
	if piece.instance_of?(King)
		piece.moveset.each do |move|
			a = piece.x_position + move[0]
			b = piece.y_position + move[1]

			if valid_position?(a, b)
				piece.possible_moves << [a, b]
			end
		end
	else
		piece.find_possible_moves(test_positions)
	end
end

=end