require "knight"
require "game"

describe Knight do 
	let(:board) { Board.new(true) }
	let(:knight) { Knight.new([4,4], true) }
	before do
		board.positions[4][4] = knight
	end

	context "movement calculations" do
		it "should move in an L shape" do
			knight.find_possible_moves(board.positions)
			expect(knight.possible_moves.sort).to eq([[2,3],[2,5],[3,2],[3,6],[5,2],[5,6],[6,3],[6,5]])
		end

		it "should be able to move over any piece" do
			board.positions[3][3] = Pawn.new([3,3], true)
			board.positions[3][4] = Pawn.new([3,4], true)
			board.positions[3][5] = Pawn.new([3,5], true)
			board.positions[4][3] = Pawn.new([4,3], true)
			board.positions[4][5] = Pawn.new([4,5], false)
			board.positions[5][3] = Pawn.new([5,3], false)
			board.positions[5][4] = Pawn.new([5,4], false)
			board.positions[5][5] = Pawn.new([5,5], false)
			knight.find_possible_moves(board.positions)
			expect(knight.possible_moves.sort).to eq([[2,3],[2,5],[3,2],[3,6],[5,2],[5,6],[6,3],[6,5]])
		end

		it "should be blocked by same color pieces" do
			board.positions[2][3] = Pawn.new([2,3], true)
			knight.find_possible_moves(board.positions)
			expect(knight.possible_moves.sort).to eq([[2,5],[3,2],[3,6],[5,2],[5,6],[6,3],[6,5]])
		end

		it "should be able to capture enemy pieces" do
			board.positions[2][3] = Pawn.new([2,3], false)
			knight.find_possible_moves(board.positions)
			expect(knight.possible_moves.sort).to eq([[2,3],[2,5],[3,2],[3,6],[5,2],[5,6],[6,3],[6,5]])
		end
	end
end