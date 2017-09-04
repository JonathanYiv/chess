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
end