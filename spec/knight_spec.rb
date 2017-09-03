require "knight"
require "gameboard"

describe Knight do 
	let(:gameboard) { GameBoard.new }
	let(:knight) { Knight.new([4,4], true) }
	before do
		gameboard.positions[4][4] = knight
	end

	context "movement calculations" do
		it "should move in an L shape" do
			knight.find_possible_moves(gameboard.positions)
			expect(knight.possible_moves.sort).to eq([[2,3],[2,5],[3,2],[3,6],[5,2],[5,6],[6,3],[6,5]])
		end

		it "should be able to move over any piece" do
			gameboard.positions[3][3] = Pawn.new([3,3], true)
			gameboard.positions[3][4] = Pawn.new([3,4], true)
			gameboard.positions[3][5] = Pawn.new([3,5], true)
			gameboard.positions[4][3] = Pawn.new([4,3], true)
			gameboard.positions[4][5] = Pawn.new([4,5], false)
			gameboard.positions[5][3] = Pawn.new([5,3], false)
			gameboard.positions[5][4] = Pawn.new([5,4], false)
			gameboard.positions[5][5] = Pawn.new([5,5], false)
			knight.find_possible_moves(gameboard.positions)
			expect(knight.possible_moves.sort).to eq([[2,3],[2,5],[3,2],[3,6],[5,2],[5,6],[6,3],[6,5]])
		end

		it "should be blocked by same color pieces" do
			gameboard.positions[2][3] = Pawn.new([2,3], true)
			knight.find_possible_moves(gameboard.positions)
			expect(knight.possible_moves.sort).to eq([[2,5],[3,2],[3,6],[5,2],[5,6],[6,3],[6,5]])
		end

		it "should be able to capture enemy pieces" do
			gameboard.positions[2][3] = Pawn.new([2,3], false)
			knight.find_possible_moves(gameboard.positions)
			expect(knight.possible_moves.sort).to eq([[2,3],[2,5],[3,2],[3,6],[5,2],[5,6],[6,3],[6,5]])
		end
	end
end