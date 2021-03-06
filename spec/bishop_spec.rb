require 'pieces/bishop'
require 'game'

describe Bishop do
  let(:board) { Board.new(true) }
  let(:bishop) { Bishop.new([4, 4], true) }
  before do
    board.positions[4][4] = bishop
  end

  context 'movement calculations' do
    it 'should move diagonally from its existing space' do
      bishop.find_possible_moves(board.positions)
      expect(bishop.possible_moves.sort).to eq([[0, 0], [1, 1], [1, 7], [2, 2],
                                                [2, 6], [3, 3], [3, 5], [5, 3],
                                                [5, 5], [6, 2], [6, 6], [7, 1],
                                                [7, 7]])
    end

    it 'should be blocked by pieces of the same color' do
      board.positions[3][3] = Pawn.new([3, 3], true)
      bishop.find_possible_moves(board.positions)
      expect(bishop.possible_moves.sort).to eq([[1, 7], [2, 6], [3, 5], [5, 3],
                                                [5, 5], [6, 2], [6, 6], [7, 1],
                                                [7, 7]])
    end

    it 'should be able to capture an enemy piece, but move no further' do
      board.positions[6][2] = Pawn.new([6, 2], false)
      bishop.find_possible_moves(board.positions)
      expect(bishop.possible_moves.sort).to eq([[0, 0], [1, 1], [1, 7], [2, 2],
                                                [2, 6], [3, 3], [3, 5], [5, 3],
                                                [5, 5], [6, 2], [6, 6], [7, 7]])
    end
  end
end
