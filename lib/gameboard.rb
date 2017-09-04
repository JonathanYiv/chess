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
		place_pieces
		display
		instructions
		get_names
		display
		turn_order
		turns
	end

	def clear
		system "clear"
		system "cls"
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
		clear
		title
		top_row
		square = 1
		@positions.each_index do |row|
			print "#{8 - row}  "
			@positions[row].each_index do |column|
				if @positions[row][column] == nil
					print square % 2 == 0 ? "│    " : "│#{"    ".bg_black}" 
					square += 1
				else
					print square % 2 == 0 ? "│ #{@positions[row][column].icon}  " : "│#{" #{@positions[row][column].icon}  ".bg_black}"
					square += 1
				end
			end
			square += 1
			puts "│"
			row == 7 ? bottom_row : rows
		end
		x_axis
	end

	def top_row
		print "   ┌────"
		7.times.each { print "┬────" }
		puts "┐"
	end

	def rows
		print "   ├────"
		7.times.each { print "┼────" }
		puts "┤"
	end

	def bottom_row
		print "   └────"
		7.times.each { print "┴────" }
		puts "┘"
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
		print "#{@player1.name.bold}'s soldiers are on the #{"light".italic} side and will go first!\n\n"
		print "#{@player2.name.bold}'s soldiers are on the #{"dark".italic} side and will go second!\n\n\n"
	end

	def turns
		update_possible_moves
		until checkmate?
			turn
			@turn_counter += 1
			check? # testing line
			# needs #promote? and #check?
		end
		@turn_counter % 2 == 0 ? win(@player1) : win(@player2)
	end

	def turn
		# prompts appropriate user for user input, calls convert and move as necessary
		player = @turn_counter % 2 == 0 ? @player2 : @player1
		color = @turn_counter % 2 == 0 ? "black" : "white"
		print "It's your turn, #{player.name.bold}! What are you going to do?\n\n"
		print "Notate your move in the form of: 'B1 to C3'\n> "

		move = player.get_move
		piece_position = convert([move[2], move[1]])
		piece_move_position = convert([move[4], move[3]])
		piece = @positions[piece_position[0]][piece_position[1]]
		
		until piece.possible_moves.include?(piece_move_position) && piece.color == color
			print "\nHmm.. That doesn't appear to be a valid move. Please try again:\n> "
			move = player.get_move
			piece_position = convert([move[2], move[1]])
			piece_move_position = convert([move[4], move[3]])
			piece = @positions[piece_position[0]][piece_position[1]]
		end

		move(piece_position, piece_move_position)
		update_possible_moves
		puts piece.possible_moves.inspect
	end

	def convert(array)
		array[0] = 7 - (array[0].to_i - 1)
		array[1] = array[1].ord - 97
		array
	end

	def update_possible_moves
		@positions.flatten.each do |piece|
			piece.find_possible_moves(@positions) if piece != nil
		end
	end

	def move(current, new)
		# moves a chess piece and updates its @possible_moves
		temp = @positions[current[0]][current[1]]
		temp.x_position = new[0]
		temp.y_position = new[1]
		@positions[current[0]][current[1]] = nil
		@positions[new[0]][new[1]] = temp
		display
	end

	def promote?
		# checks if a pawn has reached the end of the board
	end

	def promote
		# promotes a pawn to a queen/rook/knight/bishop
	end

	def check?
		# checks if a check is in play
		@positions.flatten.select { |square| square.instance_of?(King) }.each do |king|
			puts "checking.."
			if king.in_check?(@positions)
				puts "Check found!"
			end
		end
	end

	def check
		# mandates that the next player moves the king
	end

	def checkmate? 
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