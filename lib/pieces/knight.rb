require_relative "../board.rb"

class Knight < Piece
	def initialize(position, is_white)
		@moveset = [
			[-1,-2],
			[-2,-1],
			[-2,+1],
			[-1,+2],
			[+1,-2],
			[+2,-1],
			[+2,+1],
			[+1,+2]
		]
		super
	end

	def find_possible_moves(positions)
		@possible_moves = []
		
		@moveset.each do |move|
			x = @x_position + move[0]
			y = @y_position + move[1]

			if Board.includes?(x,y)
				@possible_moves << [x, y] if positions[x][y].nil? || positions[x][y].color != @color
			end
		end
	end
end