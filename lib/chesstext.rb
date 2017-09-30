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
		puts "Congratulations, #{player}! You are the Champion!"
	end

	def ChessText.promotion_prompt(player)
		print "\nYour Pawn has reached the end of the board, #{player}!\n\n"
		print "You can promote your Pawn into a Queen, Knight, Rook, or Bishop. Please input which:\n> "
	end

	def ChessText.invalid_promotion
		print "\n That doesn't appear to be something you can promote a pawn to.. Try again:\n> "
	end
end