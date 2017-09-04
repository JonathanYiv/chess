require "pawn"
require "gameboard"

describe Pawn do 
	let(:gameboard) { GameBoard.new }
	let(:white_pawn) { Pawn.new([6,4], true) }
	let(:black_pawn) { Pawn.new([1,1], false) }
	before do 
		gameboard.positions[6][4] = white_pawn
		gameboard.positions[1][1] = black_pawn
	end

	context "movement calculations" do
		context "white pawn" do
			it "can move one upward" do
				white_pawn.find_possible_moves(gameboard.positions)
				expect(white_pawn.possible_moves).to include([5,4])
			end

			it "can be blocked by a piece above it" do
				gameboard.positions[5][4] = Pawn.new([5,4], true)
				white_pawn.find_possible_moves(gameboard.positions)
				expect(white_pawn.possible_moves).not_to include([5,4])
			end

			it "can move two spaces upward on its first move" do
				white_pawn.find_possible_moves(gameboard.positions)
				expect(white_pawn.possible_moves).to include([4,4])
			end

			it "can have its double-move blocked by a piece two above it" do
				gameboard.positions[4][4] = Pawn.new([4,4], true)
				white_pawn.find_possible_moves(gameboard.positions)
				expect(white_pawn.possible_moves).not_to include([4,4]) 
			end

			it "can capture diagonally upward left" do
				gameboard.positions[5][3] = Pawn.new([5,3], false)
				white_pawn.find_possible_moves(gameboard.positions)
				expect(white_pawn.possible_moves).to include([5,3])
			end

			it "can capture diagonally upward right" do
				gameboard.positions[5][5] = Pawn.new([5,5], false)
				white_pawn.find_possible_moves(gameboard.positions)
				expect(white_pawn.possible_moves).to include([5,5])
			end

			it "can not move off the board" do
				edge_pawn = Pawn.new([0,7], true)
				gameboard.positions[0][7] = edge_pawn
				edge_pawn.find_possible_moves(gameboard.positions)
				expect(edge_pawn.possible_moves).to eq([])
			end

			it "can perform en passant"
		end

		context "black pawn" do
			it "can move one downward" do
				black_pawn.find_possible_moves(gameboard.positions)
				expect(black_pawn.possible_moves).to include([2,1])
			end

			it "can be blocked by a piece below it" do
				gameboard.positions[2][1] = Pawn.new([2,1], false)
				black_pawn.find_possible_moves(gameboard.positions)
				expect(black_pawn.possible_moves).not_to include([2,1])
			end

			it "can move two spaces downward on its first move" do
				black_pawn.find_possible_moves(gameboard.positions)
				expect(black_pawn.possible_moves).to include([3,1])
			end

			it "can have its double-move blocked by a piece two below it" do
				gameboard.positions[3][1] = Pawn.new([3,1], false)
				black_pawn.find_possible_moves(gameboard.positions)
				expect(black_pawn.possible_moves).not_to include([4,4]) 
			end

			it "can capture diagonally downward left" do
				gameboard.positions[2][0] = Pawn.new([2,0], true)
				black_pawn.find_possible_moves(gameboard.positions)
				expect(black_pawn.possible_moves).to include([2,0])
			end

			it "can capture diagonally downward right" do
				gameboard.positions[2][2] = Pawn.new([2,2], true)
				black_pawn.find_possible_moves(gameboard.positions)
				expect(black_pawn.possible_moves).to include([2,2])
			end

			it "can not move off the board" do
				edge_pawn = Pawn.new([7,0], false)
				gameboard.positions[7][0] = edge_pawn
				edge_pawn.find_possible_moves(gameboard.positions)
				expect(edge_pawn.possible_moves).to eq([])
			end

			it "can perform en passant"
		end
	end
end