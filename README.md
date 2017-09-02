# Chess Project

The goal of this project is to implement a command line [Chess](https://en.wikipedia.org/wiki/Chess) game using Ruby.

This is a project from [The Odin Project](https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project).

[Pending Project Screenshot]

## Installation

Open your Terminal/Command Line. Navigate to the directory where your version will live. Type in the following:

```
$ git clone https://github.com/JonathanYiv/chess.git
$ cd chess
$ ruby lib/game.rb
```

## Pre-Project Thoughts

1. I reflected on how to represent the chess pieces. They will have multiple values: their x-position, y-position, moveset, and icon. I could do a several layers deep mixture of hash/array, but accessing the necessary data would be ugly. Therefore, I will use classes.

2. Had a discussion with my @benjaminapetersen about Composition vs Inheritance. Read about 'has-a' vs 'is-a' relationships. Realized that for the scope of this project, chess pieces don't need to inherit anything nor would their small pieces of functionality need to be extracted into something like a module.

3. I have been looking forward to this project for a very long time. I heard talk of it in the chat, then peeked forward at it earlier, and was excited to tackle this. It will definitely be a notch in my belt.

4. I think the most difficult things to implement will be the various odd rules, like 'en passant' and 'promotion of pawns.'

5. I wonder how long this will take me. Well, here we go.

### Rules to Consider

1. Castling

	1. Description

		1. The King moves two spaces to the right or left

		2. The Rook moves over the King to be on the opposite side of the King

	2. Conditions

		1. The King has never moved

		2. The Rook has never moved

		3. The squares between the King and Rook are unoccupied

		4. The King will not castle out of, through, or into check

![Castling](castling.gif)

2. En Passant

	1. Description

		1. After a Pawn moves two ranks forward, an enemy adjacent Pawn may capture the Pawn diagonally on the turn immediately afterward.

	2. Condition

		1. The capturing Pawn must be on its fifth rank.

		2. The captured Pawn must be on an adjacent square.

		3. The captured Pawn must have moved two squares in a single move.

		4. The capture can only be made on the move immediately after the double-step move.

![En Passant](en_passant.gif)

3. Promotion

	1. Description

		1. When a Pawn reaches its eighth rank, it can be replaced by a: Queen, Knight, Rook, or Bishop

		2. The choice is not limited to previously captured pieces.

![Promotion](promotion.jpg)

4. Check

	1. Description

		1. When a King is under threat of capture.

		2. It can be exited by interposing a piece, capturing the threatening piece, or moving the King.

		3. If the player can not exit check, then it is checkmate and the player loses.

		4. Kings may not move into check.

![Check](check.gif)

### Project Structure

```ruby
class GameBoard
	instance variables:
		@positions: a 2D array containing where all the chess piece instances are located
		@player1
		@player2
		@turn_counter: initially 1
	methods:
		initialize: instantiates @positions and places pieces
			place_pieces: creates all piece instances and places them in their default starting state
		play: starts the game by calling submethods
			title: displays ASCII chess title
			display: displays the board based on where pieces are
			instructions: displays the game instructions
			get_names: sets @player1 and @player2 to Player instances
			turns: starts the turn loop, using @turn_counter to determine whose turn it is
				turn: prompts the appropriate player for user input
				convert: converts a move input to the correct position on the @positions 2D array
				move: moves a chess piece, also calls find_possible_moves to update its moveset
				promote?: checks if a pawn has reached the end of the board, if so, prompt the appropriate player to promote it to a queen/knight/rook/bishop
				check?: checks if a check is in play, if so, mandates that the next turn has the player move their king by setting all other @possible_moves to nothing
				checkmate?: checks if a checkmate is in play, if so, the game ends and a player wins
					win: displays winning text for the appropriate player
					lose: displays losing text for the appropriate player
		save: serializes @positions, @player1, @player2, and @turn_counter
		load: loads serialized data into the game and sets instance variables equal to it

class Player
	instance variables:
		@name
	methods:
		initialize: instantiates and prompts for names
			get_name: gets user input for name
		take_turn: gets user input for piece to move and where to move


class King/Rook/Bishop/Queen/Knight/Pawn
	instance variables:
		@moveset
		@x_position
		@y_position
		@possible_moves
		@icon
	methods:
		initialize(black/white): creates instance variables, takes in a parameter to determine icon color
		find_possible_moves: when initialized, @possible_moves calls this to create an array for its value. Is passed in @positions to help calculate

Additionally:
	class King/Rook/Pawn
		instance variable:
			@has_moved: true or false for castling and pawn double-step move
	class Pawn
		instance variable:
			@double_stepped: true immediately after using a double-step move
```

## Post-Project Thoughts

This project is currently incomplete.