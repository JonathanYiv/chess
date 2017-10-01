require "game"
require "board"

describe Game do
  let(:game) { Game.new }
  let(:board) { Board.new(true) }

  describe "#convert" do
    it "converts string input into numerical input" do
      expect( game.convert(["8", "a"]) ).to eq([0, 0])
    end
  end

  describe "#breaks_check?" do
    it "validates as true for a piece moving to block a check" do
      board.positions[3][3] = King.new([3,3], true)
      board.positions[7][3] = Rook.new([7,3], false)
      board.positions[3][5] = Bishop.new([3,5], true)
      game.turn_counter += 1
      expect( game.breaks_check?([3,5], [5,3]) ).to be true
    end

    it "can handle situation one" do
      board.positions[0][0] = Rook.new([0,0], false)
      board.positions[4][3] = Pawn.new([4, 3], true)
      board.positions[5][4] = Pawn.new([5,4], true)
      board.positions[4][5] = Pawn.new([4,5], true)
      board.positions[6][4] = King.new([6,4], true)
      board.positions[2][4] = Queen.new([2,4], true)
      board.positions[4][4] = King.new([4,4], false)
      board.display

      expect( game.breaks_check?([0,0], [1,0]) ).to be false
    end
  end
end