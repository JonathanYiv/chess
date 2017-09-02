require_relative "knight.rb"
require_relative "player.rb"
require_relative "queen.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "king.rb"
require_relative "pawn.rb"

class GameBoard
	attr_accessor :positions, :player1, :player2, :turn_counter

	def initialize
		@positions = Array.new(8) { Array.new(8, nil) }
		@player1 = nil
		@player2 = nil
		@turn_counter = 1
		place_pieces
	end

	def place_pieces
		@positions[7][0] = Rook.new([7,0], true)
		@positions[7][1] = Knight.new([7,1], true)
		@positions[7][2] = Bishop.new([7,2], true)
		@positions[7][3] = Queen.new([7,3], true)
		@positions[7][4] = King.new([7,4], true)
		@positions[7][5] = Bishop.new([7,5], true)
		@positions[7][6] = Knight.new([7,6], true)
		@positions[7][7] = Rook.new([7,7], true)

		0.upto(7) do |x|
			@positions[6][x] = Pawn.new([6,x], true)
		end

		@positions[0][0] = Rook.new([0,0], false)
		@positions[0][1] = Knight.new([0,1], false)
		@positions[0][2] = Bishop.new([0,2], false)
		@positions[0][3] = King.new([0,3], false)
		@positions[0][4] = Queen.new([0,4], false)
		@positions[0][5] = Bishop.new([0,5], false)
		@positions[0][6] = Knight.new([0,6], false)
		@positions[0][7] = Rook.new([0,7], false)

		0.upto(7) do |x|
			@positions[1][x] = Pawn.new([1,x], false)
		end
	end

	def play
		title
		display
		instructions
		get_names
		turns
	end

	def title
		# displays ASCII "Chess" title
		print " .d8888b.  888                                 
d88P  Y88b 888                                 
888    888 888                                 
888        88888b.   .d88b.  .d8888b  .d8888b  
888        888 \"88b d8P  Y8b 88K      88K      
888    888 888  888 88888888 \"Y8888b. \"Y8888b. 
Y88b  d88P 888  888 Y8b.          X88      X88 
 \"Y8888P\"  888  888  \"Y8888   88888P\'  88888P\' \n\n"
	end

	def display
		rows
		@positions.each_index do |row|
			print "#{8 - row}  "
			@positions[row].each_index do |column|
				if @positions[row][column] == nil
					print "|    "
				else
					print "| #{@positions[row][column].icon}  "
				end
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
		("a".."h").each { |letter| print "  #{letter}  "}
		puts "\n\n"
	end

	def instructions
		print "Instructions at https://www.chess.com/learn-how-to-play-chess\n\n"
	end

	def get_names
		# sets @player1 and @player2 to Player instances
	end

	def turns
		# turn loop
	end

	def turn
		# prompts appropriate user for user input
	end

	def convert
		# converts a move input to the correct @positions representation
	end

	def move
		# moves a chess piece and updates its @possible_moves
	end

	def promote?
		# checks if a pawn has reached the end of the board
	end

	def promote
		# promotes a pawn to a queen/rook/knight/bishop
	end

	def check?
		# checks if a check is in play
	end

	def check
		# mandates that the next player moves the king
	end

	def checkmate?
		# checks if a checkmate is in play
	end

	def win
		# displays winning text
	end

	def lose
		# displays losing text
	end

	def save
	end

	def load
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
