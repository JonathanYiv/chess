require_relative "board.rb"

class King
	attr_accessor :moveset, :x_position, :y_position, :possible_moves, :icon, :has_moved, :color

	def initialize(position, is_white)
		@moveset = [
			[1,1],
			[1,0],
			[1,-1],
			[0, 1],
			[0,-1],
			[-1,1],
			[-1,0],
			[-1,-1]
		]
		@x_position = position[0]
		@y_position = position[1]
		@possible_moves = []
		@icon = is_white ? "♚" : "♔"
		@has_moved = false
		@color =  is_white ? "white" : "black"
	end

	def find_possible_moves(positions) # this method needs to be broken into multiple
		@possible_moves = []

		@moveset.each do |move|
			x = @x_position + move[0]
			y = @y_position + move[1]

			if Board.includes?(x, y)

				test_positions = Array.new(8) { Array.new(8, nil) }
				0.upto(7) do |x|
					0.upto(7) do |y|
						original = positions[x][y]
						copy = original.nil? ? nil : original.class.new([x, y], original.color == "white")
						test_positions[x][y] = copy
						if original.instance_of?(King) || original.instance_of?(Pawn) || original.instance_of?(Rook)
							copy.has_moved = original.has_moved
							copy.double_stepped = original.double_stepped if original.instance_of?(Pawn)
						end
					end
				end
				#test_positions = Board.clone(positions)


				test_positions[@x_position][@y_position] = nil
				test_king = King.new([x, y], @color == "white")
				test_positions[x][y] = test_king

				test_positions.flatten.select { |square| square !=  nil && square.color != color }.each do |piece| 
					if piece.instance_of?(King)
						piece.moveset.each do |test_move|
							a = piece.x_position + test_move[0]
							b = piece.y_position + test_move[1]

							if Board.includes?(a, b)
								piece.possible_moves << [a, b]
							end
						end
					else
						piece.find_possible_moves(test_positions)
					end
				end
				
				@possible_moves << [x, y] if !test_king.in_check?(test_positions) && (positions[x][y].nil? || positions[x][y].color != @color)
			end
		end
		check_for_castle(positions) if @has_moved == false
	end

	def in_check?(positions)
		in_check = false
		positions.flatten.select { |piece| !piece.nil? && piece.color != @color }.each do |piece|
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

	def check_for_castle(positions)
		x = @color == "white" ? 7 : 0

		if positions[x][0].instance_of?(Rook) && positions[x][0]&.has_moved == false 
			if positions[x][1].nil? && positions[x][2].nil? && positions[x][3].nil?
				valid = true
				positions.flatten.select { |square| !square.nil? && square.color != @color }.each do |piece|
					valid = false if piece.possible_moves.include?([x, 2])
				end
				@possible_moves << [x, 2] if valid
			end
		end

		if positions[x][7].instance_of?(Rook) && positions[x][7]&.has_moved == false
			if positions[x][5].nil? && positions[x][6].nil?
				valid = true
				positions.flatten.select { |square| !square.nil? && square.color != @color }.each do |piece|
					valid = false if piece.possible_moves.include?([x, 6])
				end
				@possible_moves << [x, 6] if valid
			end
		end
	end
end