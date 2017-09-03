require_relative "knight.rb"
require_relative "player.rb"
require_relative "queen.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "king.rb"
require_relative "pawn.rb"
require_relative "string.rb"

class GameBoard
	attr_accessor :positions, :player1, :player2, :turn_counter

	def initialize
		@positions = Array.new(8) { Array.new(8, nil) }
		@player1 = nil
		@player2 = nil
		@turn_counter = 1
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
		@positions[0][3] = Queen.new([0,3], false)
		@positions[0][4] = King.new([0,4], false)
		@positions[0][5] = Bishop.new([0,5], false)
		@positions[0][6] = Knight.new([0,6], false)
		@positions[0][7] = Rook.new([0,7], false)

		0.upto(7) do |x|
			@positions[1][x] = Pawn.new([1,x], false)
		end
	end

	def play
		title
		place_pieces
		display
		instructions
		get_names
		turn_order
		turns
	end

	def title
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
		@player1 = Player.new(1)
		@player2 = Player.new(2)
	end

	def turn_order
		print "#{@player1.name.bold} is #{"White".italic} and will go first!\n"
	end

	def turns
		until checkmate?
			turn
			@turn_counter += 1
			# needs #promote? and #check?
		end
		@turn_counter % 2 == 0 ? win(@player1) : win(@player2)
	end

	def turn
		# prompts appropriate user for user input, calls convert and move as necessary
		player = @turn_counter % 2 == 0 ? @player2 : @player1
		# still needs implementation
	end

	def convert
		# converts a move input to the correct @positions representation
	end

	def update_possible_moves
		@positions.flatten.each do |piece|
			piece.find_possible_moves(@positions) if piece != nil unless piece.instance_of? King
		end
		@positions.flatten.each do |piece|
			piece.find_possible_moves(@positions) if piece.instance_of? King
		end
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
		false
	end

	def win(player)
		puts "Congratulations, #{player.name.bold}! You are the Champion!"
	end

	def save
	end

	def load
	end
end