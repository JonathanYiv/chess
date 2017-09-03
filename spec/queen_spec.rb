require "queen"
require "gameboard"

describe Queen do
	let(:gameboard) { GameBoard.new }
	let(:queen) { Queen.new([4,4], true) }
	before do
		gameboard.positions[4][4] = queen
	end

	context "movement calculations" do
		it "can move diagonally, vertically, and horizontally to the edges of the board"
		it "is blocked by same color pieces"
		it "can capture different color pieces and go no further"
	end
end