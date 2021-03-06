require 'pieces/rook'
require 'game'

describe Rook do
  let(:board) { Board.new(true) }
  let(:rook) { Rook.new([4, 4], true) }
  before do
    board.positions[4][4] = rook
  end

  context 'movement calculations' do
    it 'should move horizontally and vertically until the end of the board' do
      rook.find_possible_moves(board.positions)
      expect(rook.possible_moves.sort).to eq([[0, 4], [1, 4], [2, 4], [3, 4],
                                              [4, 0], [4, 1], [4, 2], [4, 3],
                                              [4, 5], [4, 6], [4, 7], [5, 4],
                                              [6, 4], [7, 4]])
    end

    it 'should be blocked by same color pieces' do
      board.positions[3][4] = Pawn.new([3, 4], true)
      rook.find_possible_moves(board.positions)
      expect(rook.possible_moves.sort).to eq([[4, 0], [4, 1], [4, 2], [4, 3],
                                              [4, 5], [4, 6], [4, 7], [5, 4],
                                              [6, 4], [7, 4]])
    end

    it 'should be able to capture different color pieces but go no further' do
      board.positions[3][4] = Pawn.new([3, 4], false)
      rook.find_possible_moves(board.positions)
      expect(rook.possible_moves.sort).to eq([[3, 4], [4, 0], [4, 1], [4, 2],
                                              [4, 3], [4, 5], [4, 6], [4, 7],
                                              [5, 4], [6, 4], [7, 4]])
    end
  end
end
