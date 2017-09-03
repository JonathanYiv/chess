require "pawn"
require "gameboard"

describe Pawn do 
	let(:gameboard) { GameBoard.new }
	let(:pawn) { Pawn.new([4,4], true) }
	before do
		gameboard.positions[4][4] = pawn
	end

	context "movement calculations" do
		it "should move upward if white"
		it "should move downward if black"
		it "should be able to move one space forward on any turn"
		it "should be blocked by any piece"
		it "should be able to move two spaces forward on its first turn"
		it "should be able to diagonally capture left and right"
		it "should calculate en passant"
	end
end