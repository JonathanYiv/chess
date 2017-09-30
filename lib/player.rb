require_relative "string.rb"

class Player
	attr_accessor :name

	def initialize(number)
		@name = get_name(number)
	end

	def to_s
		@name.bold
	end

	def get_name(number)
		print "Hello Player #{number}! What is your name?\n> "
		@name = gets.chomp
		puts ""
		@name
	end

	def get_move
		move = gets.chomp.downcase
		until move_format?(move)
			print "\nThat doesn't appear to be in the correct format. Remember: [Letter][Number] to [Letter][Number].\n> "
			move = gets.chomp.downcase
		end
		/^([a-h])([1-8])\s{1}to\s{1}([a-h])([1-8])$/.match(move)
	end

	def move_format?(string)
		return false if /^([a-h])([1-8])\s{1}to\s{1}([a-h])([1-8])$/.match(string).nil?
		true
	end
end

=begin
This is borrowed for inspiration from Lujan Fernaud's Chess Game code which is outstanding.
https://github.com/lujanfernaud/ruby-chess/

def sanitize(movement)
   loop do
    return board.possible_moves_for(movement) if movement =~ /\A[a-h][1-8]\z/

    return movement  if movement =~ /\A[a-h][1-8][a-h][1-8]\z/
    return save_game if movement =~ /save/
    return load_game if movement =~ /load/
    return finish    if movement =~ /exit/

    movement = please_introduce_a_correct_movement
  end
end
	
=end