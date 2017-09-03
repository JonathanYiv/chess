require "rook"
require "gameboard"

describe Rook do
	let(:gameboard) { GameBoard.new }
	let(:rook) { Rook.new([4,4], true) }
	before do
		gameboard.positions[4][4] = rook
	end

	context "movement calculations" do
		it "should move horizontally and vertically until the end of the board"
		it "should be blocked by same color pieces"
		it "should be able to capture different color pieces but go no further"
	end
end