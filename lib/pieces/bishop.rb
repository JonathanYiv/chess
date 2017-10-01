require_relative "piece.rb"

class Bishop < Piece
	def initialize(position, is_white)
		@moveset = [
			[1,1],
			[1,-1],
			[-1,1],
			[-1,-1]
		]
		@icon = is_white ? "♝" : "♗"
		super
	end
end