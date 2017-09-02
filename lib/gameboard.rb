class GameBoard
	attr_accessor :pieces, :positions, :knight

	def initialize
		@pieces = {
			black_king: "♔",
			black_queen: "♕",
			black_rook: "♖",
			black_bishop: "♗",
			black_knight: "♘",
			black_pawn: "♙",
			white_king: "♚",
			white_queen: "♛",
			white_rook: "♜",
			white_bishop: "♝",
			white_knight: "♞",
			white_pawn: "♟" 
		}
		@positions = Array.new(8) { Array.new(8, " ") }
	end

	def display
		rows
		@positions.each_index do |row|
			print "#{row}  "
			@positions[row].each_index do |column|
				print "| #{@positions[row][column]}  "
			end
			puts "|"
			rows
		end
		x_axis
	end

	def rows
		print "   "
		8.times.each { print "+----" }
		puts "+"
	end

	def x_axis
		print "   "
		(0..7).each { |letter| print "  #{letter}  "}
		puts ""
	end
end

=begin
Chess Board
0,0 0,1 0,2 0,3 0,4 0,5 0,6 0,7
1,0 1,1 1,2 1,3 1,4 1,5 1,6 1,7
2,0 2,1 2,2 2,3 2,4 2,5 2,6 2,7
3,0 3,1 3,2 3,3 3,4 3,5 3,6 3,7
4,0 4,1 4,2 4,3 4,4 4,5 4,6 4,7
5,0 5,1 5,2 5,3 5,4 5,5 5,6 5,7
6,0 6,1 6,2 6,3 6,4 6,5 6,6 6,7
7,0 7,1 7,2 7,3 7,4 7,5 7,6 7,7
=end
