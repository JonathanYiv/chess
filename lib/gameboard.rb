require_relative "knight.rb"
require_relative "player.rb"
require_relative "queen.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "king.rb"
require_relative "pawn.rb"
require_relative "string.rb"
require "pry"
require "yaml"

class GameBoard
	attr_accessor :positions, :player1, :player2, :turn_counter

	def initialize
		@positions = Array.new(8) { Array.new(8, nil) }
		@player1 = nil
		@player2 = nil
		@turn_counter = 0
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
		ChessText.instructions
		get_names
		display
		turn_order
		turns
	end

	def clear
		system "clear"
		system "cls"
	end

	def display
		clear
		ChessText.title
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
		until checkmate? == true
			if check?
				check_turn
			else
				turn
			end
			display
		end
		@turn_counter -= 1
		ChessText.win(turn_player)
	end

	def turn_player
		@turn_counter % 2 == 0 ? @player2 : @player1
	end

	def turn_color
		@turn_counter % 2 == 0 ? "black" : "white"
	end

	def turn
		print "It's your turn, #{turn_player.name.bold}! What are you going to do?\n\n"
		print "Notate your move in the form of: 'B1 to C3'\n> "

		move, piece_position, piece_move_position = nil, nil, nil

		loop do
			move = turn_player.get_move
			piece_position = convert([move[2], move[1]])
			piece_move_position = convert([move[4], move[3]])
			piece = @positions[piece_position[0]][piece_position[1]]
			break if piece != nil && piece.possible_moves.include?(piece_move_position) && piece.color == turn_color
			print "\nHmm.. That doesn't appear to be a valid move. Please try again:\n> "
		end

		move(piece_position, piece_move_position)
	end

	def check_turn
		print "Your King is in check, #{turn_player.name.bold}! You better do something!\n> "

		move, piece_position, piece_move_position = nil, nil, nil

		loop do
			move = turn_player.get_move
			piece_position = convert([move[2], move[1]])
			piece_move_position = convert([move[4], move[3]])
			piece = @positions[piece_position[0]][piece_position[1]]
			break if piece.possible_moves.include?(piece_move_position) && piece.color == turn_color && breaks_check?(piece_position, piece_move_position) == true
			print "\nThat still leaves your King in check. Try again:\n> "
		end

		move(piece_position, piece_move_position)
	end

	def breaks_check?(current, new)
		breaks_check = false
		cache = clone_positions

		move(current, new)
		@positions.flatten.select { |square| !square.nil? && square.instance_of?(King) && square.color == turn_color }.each do |king|
			breaks_check = true if king.in_check?(@positions) == false
		end
		@positions = cache
		update_possible_moves
		breaks_check
	end

	def clone_positions
		cache = Array.new(8) { Array.new(8, nil) }
		0.upto(7) do |x|
			0.upto(7) do |y|
				original = @positions[x][y]
				copy = original.nil? ? nil : original.class.new([x, y], original.color == "white")
				cache[x][y] = copy
				if original.instance_of?(King) || original.instance_of?(Pawn) || original.instance_of?(Rook)
					copy.has_moved = original.has_moved
					copy.double_stepped = original.double_stepped if original.instance_of?(Pawn)
				end
			end
		end
		cache
	end

	def convert(array)
		array[0] = 7 - (array[0].to_i - 1)
		array[1] = array[1].ord - 97
		array
	end

	def update_possible_moves
		@positions.flatten.each do |piece|
			piece&.find_possible_moves(@positions) unless piece.instance_of?(King)
		end
		@positions.flatten.each do |piece|
			piece&.find_possible_moves(@positions) if piece.instance_of?(King)
		end
	end

	def move(current, new)
		double_stepped = check_for_double_step(current, new) 

		if en_passant?(current, new) 
			@positions[current[0]][new[1]] = nil
		end

		if castle?(current, new)
			case new
			when [7, 2]
				temp = @positions[7][0]
				@positions[7][0] = nil
				@positions[7][3] = temp
				temp.x_position = 7
				temp.y_position = 3
			when [7, 6]
				temp = @positions[7][7]
				@positions[7][7] = nil
				@positions[7][5] = temp
				temp.x_position = 7
				temp.y_position = 5
			when [0, 2]
				temp = @positions[0][0]
				@positions[0][0] = nil
				@positions[0][3] = temp
				temp.x_position = 0
				temp.y_position = 3
			when [0, 6]
				temp = @positions[0][7]
				@positions[0][7] = nil
				@positions[0][5] = temp
				temp.x_position = 0
				temp.y_position = 5
			end
		end
		temp = @positions[current[0]][current[1]]
		if temp != nil
			temp.x_position = new[0]
			temp.y_position = new[1]
		end
			
		@positions[current[0]][current[1]] = nil
		@positions[new[0]][new[1]] = temp

		temp.has_moved = true if temp.instance_of?(King) || temp.instance_of?(Rook) || temp.instance_of?(Pawn)

		if temp.instance_of?(Pawn)
			temp.double_stepped = false if temp.double_stepped == true
			temp.double_stepped = true if double_stepped
		end

		promote_pawn = promote?
		promote(promote_pawn) if !promote_pawn.nil?
		update_possible_moves
	end

	def check_for_double_step(current, new)
		piece = @positions[current[0]][current[1]]
		if piece.instance_of?(Pawn) && (piece.x_position - new[0]).abs == 2
			return true
		end
		false
	end

	def castle?(current, new)
		castle_moves = [[7, 2], [7, 6], [0, 2], [0, 6]]
		piece = @positions[current[0]][current[1]]
		if piece.instance_of?(King) && piece.has_moved == false && castle_moves.include?(new)
			return true
		end
		false
	end

	def en_passant?(current, new) 
		piece = @positions[current[0]][current[1]]

		if piece.instance_of?(Pawn) && @positions[new[0]][new[1]].nil? && current[1] != new[1]
			return true
		end
		false
	end

	def promote?
		promote_pawn = nil
		0.upto(7) do |x|
			promote_pawn = @positions[0][x] if @positions[0][x].instance_of?(Pawn)
			promote_pawn = @positions[7][x] if @positions[7][x].instance_of?(Pawn)
		end
		promote_pawn
	end

	def promote(pawn)
		acceptable_input = ["queen", "knight", "rook", "bishop"]
		ChessText.promotion
		promotion = gets.chomp.downcase

		until acceptable_input.include?(promotion)
			ChessText.invalid_promotion
			promotion = gets.chomp.downcase
		end

		case promotion
		when "queen"
			@positions[pawn.x_position][pawn.y_position] = Queen.new([pawn.x_position, pawn.y_position], pawn.color)
		when "knight"
			@positions[pawn.x_position][pawn.y_position] = Knight.new([pawn.x_position, pawn.y_position], pawn.color)
		when "rook"
			@positions[pawn.x_position][pawn.y_position] = Rook.new([pawn.x_position, pawn.y_position], pawn.color)
		when "bishop"
			@positions[pawn.x_position][pawn.y_position] = Bishop.new([pawn.x_position, pawn.y_position], pawn.color)
		end
	end

	def check?
		color = turn_color
		@positions.flatten.select { |square| square.instance_of?(King) && square.color == color }.each do |king|
			if king.in_check?(@positions)
				return true
			end
		end
		false
	end

	def checkmate?
		@turn_counter += 1
		@positions.flatten.select {|square| square.instance_of?(King) && square.color == turn_color }.each do |king|
			return false if !king.in_check?(@positions)
			return false if any_breaks_checks? == true
			return false if !king.possible_moves.empty?
		end
		true
	end

	def any_breaks_checks?
		@positions.flatten.select { |square| !square.nil? && square.color == turn_color }.each do |piece|
			piece.possible_moves.each do |move|
				if breaks_check?([piece.x_position, piece.y_position], move)
					return true
				end
			end
		end
		false
	end
end

class ChessText
		def ChessText.title
		print " .d8888b.  888                                 
d88P  Y88b 888                                 
888    888 888                                 
888        88888b.   .d88b.  .d8888b  .d8888b  
888        888 \"88b d8P  Y8b 88K      88K      
888    888 888  888 88888888 \"Y8888b. \"Y8888b. 
Y88b  d88P 888  888 Y8b.          X88      X88 
 \"Y8888P\"  888  888  \"Y8888   88888P\'  88888P\' \n\n"
	end

	def ChessText.instructions
		print "Instructions at https://www.chess.com/learn-how-to-play-chess\n\n"
	end

	def ChessText.win(player)
		puts "Congratulations, #{player.name.bold}! You are the Champion!"
	end

	def ChessText.promotion_prompt
		print "\nYour Pawn has reached the end of the board, #{turn_player.name.bold}!\n\n"
		print "You can promote your Pawn into a Queen, Knight, Rook, or Bishop. Please input which:\n> "
	end

	def ChessText.invalid_promotion
		print "\n That doesn't appear to be something you can promote a pawn to.. Try again:\n> "
	end
end