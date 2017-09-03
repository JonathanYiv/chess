class Player
	attr_accessor :name

	def initialize(number)
		@name = get_name(number)
	end

	def get_name(number)
		print "Hello Player #{number}! What is your name?\n> "
		@name = gets.chomp
		puts ""
		@name
	end

	def take_turn
		# get user input for piece to move and where to move
	end
end