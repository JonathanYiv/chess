require "gameboard"

describe GameBoard do
	let(:gameboard) { GameBoard.new }

	describe "#convert" do
		it "converts string input into numerical input" do
			expect( gameboard.convert(["8", "a"]) ).to eq([0, 0])
		end
	end
end