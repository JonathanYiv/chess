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
		@positions = Array.new(8) { Array.new(8, " ") }
		@player1 = nil
		@player2 = nil
		@turn_counter = 1
		place_pieces
	end

	def place_pieces
		# creates all piece instances and places them in their default starting position
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
	end

	def display
		rows
		@positions.each_index do |row|
			print "#{row}  " # need to change to 1-8 upwards
			@positions[row].each_index do |column|
				print "| #{@positions[row][column]}  " # need to update to call the object's icon. If nil, then just put a space
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
		("a".."h").each { |letter| print "  #{letter}  "} # need to change to letters
		puts ""
	end

	def instructions
		# displays instructions
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
