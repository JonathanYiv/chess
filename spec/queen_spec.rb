require 'pieces/queen'
require 'game'

describe Queen do
  let(:board) { Board.new(true) }
  let(:queen) { Queen.new([4, 4], true) }
  before do
    board.positions[4][4] = queen
  end

  context 'movement calculations' do
    it 'can move diagonally/vertically/horizontally to the board edges' do
      queen.find_possible_moves(board.positions)
      expect(queen.possible_moves.sort).to eq([[0, 0], [0, 4], [1, 1], [1, 4],
                                               [1, 7], [2, 2], [2, 4], [2, 6],
                                               [3, 3], [3, 4], [3, 5], [4, 0],
                                               [4, 1], [4, 2], [4, 3], [4, 5],
                                               [4, 6], [4, 7], [5, 3], [5, 4],
                                               [5, 5], [6, 2], [6, 4], [6, 6],
                                               [7, 1], [7, 4], [7, 7]])
    end

    it 'is blocked by same color pieces' do
      board.positions[3][3] = Pawn.new([3, 3], true)
      board.positions[3][4] = Pawn.new([3, 4], true)
      board.positions[3][5] = Pawn.new([3, 5], true)
      board.positions[4][3] = Pawn.new([4, 3], true)
      board.positions[4][5] = Pawn.new([4, 5], true)
      board.positions[5][3] = Pawn.new([5, 3], true)
      board.positions[5][4] = Pawn.new([5, 4], true)
      board.positions[5][5] = Pawn.new([5, 5], true)
      queen.find_possible_moves(board.positions)
      expect(queen.possible_moves.sort).to eq([])
    end

    it 'can capture different color pieces and go no further' do
      board.positions[3][3] = Pawn.new([3, 3], false)
      board.positions[3][4] = Pawn.new([3, 4], false)
      board.positions[3][5] = Pawn.new([3, 5], false)
      board.positions[4][3] = Pawn.new([4, 3], false)
      board.positions[4][5] = Pawn.new([4, 5], false)
      board.positions[5][3] = Pawn.new([5, 3], false)
      board.positions[5][4] = Pawn.new([5, 4], false)
      board.positions[5][5] = Pawn.new([5, 5], false)
      queen.find_possible_moves(board.positions)
      expect(queen.possible_moves.sort).to eq([[3, 3], [3, 4], [3, 5], [4, 3],
                                               [4, 5], [5, 3], [5, 4], [5, 5]])
    end
  end
end
