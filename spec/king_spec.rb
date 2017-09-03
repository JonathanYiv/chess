require "king"
require "gameboard"

describe King do
	let(:gameboard) { GameBoard.new }
	let(:king) { King.new([4,4], true) }
	before do
		gameboard.positions[4][4] = king
	end

	context "movement calculations" do
		it "can move one space in any direction" do
			king.find_possible_moves(gameboard.positions)
			expect(king.possible_moves.sort).to eq([[3,3],[3,4],[3,5],[4,3],[4,5],[5,3],[5,4],[5,5]])
		end

		it "should be blocked by a piece of the same color" do
			gameboard.positions[3][3] = Pawn.new([3,3], true)
			gameboard.positions[3][4] = Pawn.new([3,4], true)
			gameboard.positions[3][5] = Pawn.new([3,5], true)
			gameboard.positions[4][3] = Pawn.new([4,3], true)
			gameboard.positions[4][5] = Pawn.new([4,5], true)
			gameboard.positions[5][3] = Pawn.new([5,3], true)
			gameboard.positions[5][4] = Pawn.new([5,4], true)
			king.find_possible_moves(gameboard.positions)
			expect(king.possible_moves.sort).to eq([[5,5]])
		end

		it "should be blocked by enemy movesets" do
			gameboard.positions[0][3] = Rook.new([0,3], false)
			gameboard.positions[6][7] = Bishop.new([6,7], false)
			gameboard.positions[6][3] = King.new([6,3], false)
			gameboard.update_possible_moves
			expect(king.possible_moves.sort).to eq([[3,5], [5,5]])
		end

		it "shouldn't be able to capture a piece that another piece can move onto" do
			gameboard.positions[3][5] = Pawn.new([3,5], false) # FUCK, the pawn's possible move forward DOES NOT COUNT
			# ALSO THE BLACK PAWN DIAGONAL CAPTURE IS BROKEN
			#gameboard.positions[2][6] = Pawn.new([2,6], false)
			gameboard.positions[0][5] = Rook.new([0,5], false)
			gameboard.display
			king.find_possible_moves(gameboard.positions)
			expect(king.possible_moves.sort).to eq([[3,3],[3,4],[4,3],[4,5],[5,3],[5,4],[5,5]])
		end

		it "should allow castling"
	end
end