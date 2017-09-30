class Board
	attr_accessor :positions

	def initialize
		@positions = Array.new(8) { Array.new(8, nil) }
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
		@positions[0][3] = Queen.new([0,3], false)
		@positions[0][4] = King.new([0,4], false)
		@positions[0][5] = Bishop.new([0,5], false)
		@positions[0][6] = Knight.new([0,6], false)
		@positions[0][7] = Rook.new([0,7], false)

		0.upto(7) do |x|
			@positions[1][x] = Pawn.new([1,x], false)
		end
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

	def clear
		system "clear"
		system "cls"
	end

	def top_row
		puts "   ┌────┬────┬────┬────┬────┬────┬────┬────┐"
	end

	def rows
		puts "   ├────┼────┼────┼────┼────┼────┼────┼────┤"
	end

	def bottom_row
		puts "   └────┴────┴────┴────┴────┴────┴────┴────┘"
	end

	def x_axis
		puts "     a    b    c    d    e    f    g    h  \n\n"
	end
end