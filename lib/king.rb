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

			if valid_position?(x,y) 
				if positions[x][y] == nil || positions[x][y].color != @color
					temp = positions[x][y] # this is a test line
					color = @color == "white" ? true : false # this is a test line
					positions[x][y] = King.new([x,y], color) # this is a test line

					illegal_move = check_for_checks?(positions, x, y)
					
					@possible_moves << [x, y] if illegal_move == false

					positions[x][y] = temp # this is a test line
				end
			end
		end
	end

	def check_for_checks?(positions, x, y)
		positions.flatten.each do |piece|
			if piece != nil
				if piece.color != @color
					piece.find_possible_moves(positions) unless piece.instance_of? King # this is a test line
					if piece.possible_moves.include?([x, y])
						return true
					end
					
					if piece.instance_of? King
						piece.moveset.each do |piece_move|
							a = piece.x_position + piece_move[0]
							b = piece.y_position + piece_move[1]

							return true if [x, y] == [a, b]
						end
					end
				end
			end
		end
		false
	end
end