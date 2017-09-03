require "pawn"
require "gameboard"

describe Pawn do 
	let(:gameboard) { GameBoard.new }
	let(:white_pawn) { Pawn.new([4,4], true) }
	let(:black_pawn) { Pawn.new([4,0], false) }
	before do 
		gameboard.positions[4][4] = white_pawn
		white_pawn.has_moved = true
		gameboard.positions[4][0] = black_pawn
		black_pawn.has_moved = true
	end

	context "movement calculations" do
		it "should move upward if white" do
			white_pawn.find_possible_moves(gameboard.positions)
			expect(white_pawn.possible_moves).to eq([[3,4]])
		end

		it "should move downward if black" do
			black_pawn.find_possible_moves(gameboard.positions)
			expect(black_pawn.possible_moves).to eq([[5,0]])
		end

		it "should be blocked by any piece" do
			gameboard.positions[5][0] = King.new([5,0], false)
			gameboard.positions[3][4] = Pawn.new([3,4], false)
			gameboard.update_possible_moves
			expect(white_pawn.possible_moves).to eq([])
			expect(black_pawn.possible_moves).to eq([])
		end

		it "should be able to move two spaces forward on its first turn" do
			white_pawn.has_moved = false
			white_pawn.find_possible_moves(gameboard.positions)
			expect(white_pawn.possible_moves).to eq([[3,4],[2,4]])
		end

		it "shouldn't be able to move two spaces forward if there is a piece directly in front of it" do
			white_pawn.has_moved = false
			gameboard.positions[3][4] = Pawn.new([3,4], false)
			white_pawn.find_possible_moves(gameboard.positions)
			expect(white_pawn.possible_moves).to eq([])
		end

		it "white should be able to diagonally capture left and right" do
			gameboard.positions[3][3] = Pawn.new([3,3], false)
			white_pawn.find_possible_moves(gameboard.positions)
			expect(white_pawn.possible_moves.sort).to eq([[3,3],[3,4]])
		end

		it "black should be able to diagonally capture left and right" do
			gameboard.positions[4][2] = Pawn.new([4,2], false)
			gameboard.positions[5][1] = Pawn.new([5,1], true)
			gameboard.positions[5][3] = Pawn.new([5,3], true)

			gameboard.positions[3][1] = Pawn.new([3,1], true)
			gameboard.positions[3][3] = Pawn.new([3,3], true)
			gameboard.display
			black_pawn = gameboard.positions[4][2]
			black_pawn.has_moved = true
			black_pawn.find_possible_moves(gameboard.positions)
			expect(black_pawn.possible_moves.sort).to eq([[5,1],[5,2],[5,3]])
		end

		it "should calculate en passant"
	end
end