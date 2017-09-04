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