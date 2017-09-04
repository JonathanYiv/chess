require "king"
require "gameboard"

describe King do
	let(:gameboard) { GameBoard.new }
	let(:king) { King.new([4,4], true) }
	before do
		gameboard.positions[4][4] = king
	end

	context "movement calculations" do
		it "can move one space in any direction (provided no impediments)"
		it "can't move onto a space with a friendly piece"
		it "can't move onto a space which would put it into check"
		it "can't capture a piece that would put it into check"
		it "should allow castling"
	end

	context "in check" do
		it "shows in check when a pawn is threatening" do
			gameboard.positions[3][5] = Pawn.new([3,5], false)
			gameboard.update_possible_moves
			expect( king.in_check?(gameboard.positions) ).to be true
		end 

		it "shows in check when a bishop is threatening" do
			gameboard.positions[0][0] = Bishop.new([0,0], false)
			gameboard.update_possible_moves
			expect( king.in_check?(gameboard.positions) ).to be true
		end

		it "shows in check when a queen is threatening" do
			gameboard.positions[7][1] = Queen.new([7,1], false)
			gameboard.update_possible_moves
			expect( king.in_check?(gameboard.positions) ).to be true
		end

		it "shows in check when a rook is threatening" do
			gameboard.positions[6][4] = Rook.new([6,4], false)
			gameboard.update_possible_moves
			expect( king.in_check?(gameboard.positions) ).to be true
		end

		it "shows in check when a knight is threatening" do
			gameboard.positions[5][2] = Knight.new([5,2], false)
			gameboard.update_possible_moves
			expect( king.in_check?(gameboard.positions) ).to be true
		end
	end
end