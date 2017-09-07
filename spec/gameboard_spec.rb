require "gameboard"

describe GameBoard do
	let(:gameboard) { GameBoard.new }

	describe "#convert" do
		it "converts string input into numerical input" do
			expect( gameboard.convert(["8", "a"]) ).to eq([0, 0])
		end
	end

	describe "#breaks_check?" do
		it "validates as true for a piece moving to block a check" do
			gameboard.positions[3][3] = King.new([3,3], true)
			gameboard.positions[7][3] = Rook.new([7,3], false)
			gameboard.positions[3][5] = Bishop.new([3,5], true)
			gameboard.turn_counter += 1
			expect( gameboard.breaks_check?([3,5], [5,3]) ).to be true
		end

		it "can handle situation one" do
			gameboard.positions[0][0] = Rook.new([0,0], false)
			gameboard.positions[4][3] = Pawn.new([4, 3], true)
			gameboard.positions[5][4] = Pawn.new([5,4], true)
			gameboard.positions[4][5] = Pawn.new([4,5], true)
			gameboard.positions[6][4] = King.new([6,4], true)
			gameboard.positions[2][4] = Queen.new([2,4], true)
			gameboard.positions[4][4] = King.new([4,4], false)
			gameboard.display

			expect( gameboard.breaks_check?([0,0], [1,0]) ).to be false
		end
	end
end