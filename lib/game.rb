require_relative "knight.rb"
require_relative "player.rb"
require_relative "queen.rb"
require_relative "rook.rb"
require_relative "bishop.rb"
require_relative "king.rb"
require_relative "pawn.rb"
require_relative "string.rb"
require_relative "chesstext.rb"
require_relative "board.rb"
require "pry"
require "yaml"

class Game
	attr_accessor :positions, :player1, :player2, :turn_counter, :board

	def initialize
		@board = Board.new
		@player1 = nil
		@player2 = nil
		@turn_counter = 0
	end

	def play
		@board.display
		ChessText.instructions
		create_players
		@board.display
		turn_order
		turns
	end

	def create_players
		@player1 = Player.new(1)
		@player2 = Player.new(2)
	end

	def turn_order
		print "#{@player1}'s soldiers are on the #{"light".italic} side and will go first!\n\n"
		print "#{@player2}'s soldiers are on the #{"dark".italic} side and will go second!\n\n\n"
	end

	def turns
		update_possible_moves
		until checkmate? == true
			if check?
				check_turn
			else
				turn
			end
			@board.display
		end
		@turn_counter -= 1
		ChessText.win(current_player)
	end

	def current_player
		@turn_counter % 2 == 0 ? @player2 : @player1
	end

	def current_color
		@turn_counter % 2 == 0 ? "black" : "white"
	end

	def turn
		print "It's your turn, #{current_player}! What are you going to do?\n\n"
		print "Notate your move in the form of: 'B1 to C3'\n> "

		move, piece_position, piece_move_position = nil, nil, nil

		loop do
			move = current_player.get_move
			piece_position = convert([move[2], move[1]])
			piece_move_position = convert([move[4], move[3]])
			piece = @board.positions[piece_position[0]][piece_position[1]]
			break if piece != nil && piece.possible_moves.include?(piece_move_position) && piece.color == current_color
			print "\nHmm.. That doesn't appear to be a valid move. Please try again:\n> "
		end

		move(piece_position, piece_move_position)
	end

	def check_turn
		print "Your King is in check, #{current_player}! You better do something!\n> "

		move, piece_position, piece_move_position = nil, nil, nil

		loop do
			move = current_player.get_move
			piece_position = convert([move[2], move[1]])
			piece_move_position = convert([move[4], move[3]])
			piece = @board.positions[piece_position[0]][piece_position[1]]
			break if piece.possible_moves.include?(piece_move_position) && piece.color == current_color && breaks_check?(piece_position, piece_move_position) == true
			print "\nThat still leaves your King in check. Try again:\n> "
		end

		move(piece_position, piece_move_position)
	end

	def breaks_check?(current, new)
		breaks_check = false
		cache = Board.clone(@board.positions)

		move(current, new)
		@board.positions.flatten.select { |square| !square.nil? && square.instance_of?(King) && square.color == current_color }.each do |king|
			breaks_check = true if king.in_check?(@board.positions) == false
		end
		@board.positions = cache
		update_possible_moves
		breaks_check
	end

	def convert(array)
		array[0] = 7 - (array[0].to_i - 1)
		array[1] = array[1].ord - 97
		array
	end

	def update_possible_moves
		@board.positions.flatten.each do |piece|
			piece&.find_possible_moves(@board.positions) unless piece.instance_of?(King)
		end
		@board.positions.flatten.each do |piece|
			piece&.find_possible_moves(@board.positions) if piece.instance_of?(King)
		end
	end

	def move(current, new)
		double_stepped = check_for_double_step(current, new) 

		if en_passant?(current, new) 
			@board.positions[current[0]][new[1]] = nil
		end

		if castle?(current, new)
			case new
			when [7, 2]
				temp = @board.positions[7][0]
				@board.positions[7][0] = nil
				@board.positions[7][3] = temp
				temp.x_position = 7
				temp.y_position = 3
			when [7, 6]
				temp = @board.positions[7][7]
				@board.positions[7][7] = nil
				@board.positions[7][5] = temp
				temp.x_position = 7
				temp.y_position = 5
			when [0, 2]
				temp = @board.positions[0][0]
				@board.positions[0][0] = nil
				@board.positions[0][3] = temp
				temp.x_position = 0
				temp.y_position = 3
			when [0, 6]
				temp = @board.positions[0][7]
				@board.positions[0][7] = nil
				@board.positions[0][5] = temp
				temp.x_position = 0
				temp.y_position = 5
			end
		end
		temp = @board.positions[current[0]][current[1]]
		if temp != nil
			temp.x_position = new[0]
			temp.y_position = new[1]
		end
			
		@board.positions[current[0]][current[1]] = nil
		@board.positions[new[0]][new[1]] = temp

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
		piece = @board.positions[current[0]][current[1]]
		if piece.instance_of?(Pawn) && (piece.x_position - new[0]).abs == 2
			return true
		end
		false
	end

	def castle?(current, new)
		castle_moves = [[7, 2], [7, 6], [0, 2], [0, 6]]
		piece = @board.positions[current[0]][current[1]]
		if piece.instance_of?(King) && piece.has_moved == false && castle_moves.include?(new)
			return true
		end
		false
	end

	def en_passant?(current, new) 
		piece = @board.positions[current[0]][current[1]]

		if piece.instance_of?(Pawn) && @board.positions[new[0]][new[1]].nil? && current[1] != new[1]
			return true
		end
		false
	end

	def promote?
		promote_pawn = nil
		0.upto(7) do |x|
			promote_pawn = @board.positions[0][x] if @board.positions[0][x].instance_of?(Pawn)
			promote_pawn = @board.positions[7][x] if @board.positions[7][x].instance_of?(Pawn)
		end
		promote_pawn
	end

	def promote(pawn)
		acceptable_input = ["queen", "knight", "rook", "bishop"]
		ChessText.promotion_prompt(current_player)
		promotion = gets.chomp.downcase

		until acceptable_input.include?(promotion)
			ChessText.invalid_promotion
			promotion = gets.chomp.downcase
		end

		case promotion
		when "queen"
			@board.positions[pawn.x_position][pawn.y_position] = Queen.new([pawn.x_position, pawn.y_position], pawn.color)
		when "knight"
			@board.positions[pawn.x_position][pawn.y_position] = Knight.new([pawn.x_position, pawn.y_position], pawn.color)
		when "rook"
			@board.positions[pawn.x_position][pawn.y_position] = Rook.new([pawn.x_position, pawn.y_position], pawn.color)
		when "bishop"
			@board.positions[pawn.x_position][pawn.y_position] = Bishop.new([pawn.x_position, pawn.y_position], pawn.color)
		end
	end

	def check?
		color = current_color
		@board.positions.flatten.select { |square| square.instance_of?(King) && square.color == color }.each do |king|
			if king.in_check?(@board.positions)
				return true
			end
		end
		false
	end

	def checkmate?
		@turn_counter += 1
		@board.positions.flatten.select {|square| square.instance_of?(King) && square.color == current_color }.each do |king|
			return false if !king.in_check?(@board.positions)
			return false if any_breaks_checks? == true
			return false if !king.possible_moves.empty?
		end
		true
	end

	def any_breaks_checks?
		@board.positions.flatten.select { |square| !square.nil? && square.color == current_color }.each do |piece|
			piece.possible_moves.each do |move|
				if breaks_check?([piece.x_position, piece.y_position], move)
					return true
				end
			end
		end
		false
	end
end