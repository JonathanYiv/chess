require "king"
require "gameboard"

describe King do
	let(:gameboard) { GameBoard.new }
	let(:king) { King.new([4,4], true) }
	let(:enemy_king) { King.new([0,0], false) }
	before do
		gameboard.positions[0][0] = enemy_king
		gameboard.positions[4][4] = king
	end

	context "movement calculations" do
		it "can move one space in any direction (provided no impediments)" do
			king.find_possible_moves(gameboard.positions)
			expect( king.possible_moves.sort ).to eq([[3, 3], [3, 4], [3, 5], [4, 3], [4, 5], [5, 3], [5, 4], [5, 5]])
		end

		it "can't move onto a space with a friendly piece" do
			gameboard.positions[3][3] = Pawn.new([3,3], true)
			king.find_possible_moves(gameboard.positions)
			expect( king.possible_moves.sort ).to eq([[3, 4], [3, 5], [4, 3], [4, 5], [5, 3], [5, 4], [5, 5]])
		end

		it "can't capture a friendly queen" do
			gameboard.positions[0][0] = nil
			gameboard.positions[0][4] = enemy_king
			gameboard.positions[0][3] = Queen.new([0,3], false)
			gameboard.update_possible_moves
			expect( enemy_king.possible_moves ).not_to include([0,3])
		end

		it "can't move onto a space which would put it into check" do
			gameboard.positions[3][3] = Queen.new([3,3], false)
			gameboard.update_possible_moves
			expect( king.possible_moves.sort ).to eq([[3,3], [4,5], [5,4]])
		end

		it "can't capture a piece that would put it into check" do
			gameboard.positions[3][5] = Pawn.new([3,5], false)
			gameboard.positions[2][6] = Pawn.new([2,6], false)
			gameboard.positions[3][5].find_possible_moves(gameboard.positions)
			gameboard.positions[2][6].find_possible_moves(gameboard.positions)
			king.find_possible_moves(gameboard.positions)
			expect( king.possible_moves.sort ).to eq([[3, 3], [3, 4], [4, 3], [4, 5], [5, 3], [5, 4], [5, 5]])
		end

		it "can move onto a space directly in front of a pawn" do
			gameboard.positions[2][5] = Pawn.new([2,5], false)
			king.find_possible_moves(gameboard.positions)
			expect( king.possible_moves.sort ).to include([3,5])
		end

		it "can move onto a space two in front of a pawn" do
			gameboard.positions[1][4] = Pawn.new([1,4], false)
			king.find_possible_moves(gameboard.positions)
			expect( king.possible_moves.sort ).to include([3,4])
		end

		it "can not move off the board" do
			edge_king = King.new([0,7], true)
			gameboard.positions[0][7] = edge_king
			edge_king.find_possible_moves(gameboard.positions)
			expect( edge_king.possible_moves.sort ).to eq([[0,6], [1,6], [1,7]])
		end

		it "can not move towards an enemy king" do
			enemy_king = King.new([2,4], false)
			gameboard.positions[2][4] = enemy_king
			gameboard.update_possible_moves
			expect( king.possible_moves ).not_to include([3,3], [3,4], [3,5])
		end

		it "can not capture a piece towards an enemy king" do
			enemy_king = King.new([2,4], false)
			gameboard.positions[2][4] = enemy_king
			gameboard.positions[3][4] = Pawn.new([3,4], false)
			gameboard.update_possible_moves
			expect( king.possible_moves ).not_to include([3,3], [3,4], [3,5])
		end

		it "should allow castling"
	end

	context "in check" do
		it "shows in check when a pawn is threatening" do
			gameboard.positions[3][5] = Pawn.new([3,5], false)
			gameboard.positions[3][5].find_possible_moves(gameboard.positions)
			expect( king.in_check?(gameboard.positions) ).to be true
		end 

		it "shows in check when a bishop is threatening" do
			gameboard.positions[1][1] = Bishop.new([1,1], false)
			gameboard.update_possible_moves
			expect( king.in_check?(gameboard.positions) ).to be true
		end

		it "shows in check when a queen is threatening" do
			gameboard.positions[7][1] = Queen.new([7,1], false)
			gameboard.update_possible_moves
			expect( king.in_check?(gameboard.positions) ).to be true
		end

		it "shows in check when a rook is threatening" do
			gameboard.positions[6][4] = Rook.new([6,4], false)
			gameboard.update_possible_moves
			expect( king.in_check?(gameboard.positions) ).to be true
		end

		it "shows in check when a knight is threatening" do
			gameboard.positions[5][2] = Knight.new([5,2], false)
			gameboard.update_possible_moves
			expect( king.in_check?(gameboard.positions) ).to be true
		end
	end

	context "black king inappropriate movement bug" do
		it "should not be able to capture adjacent same-colored pieces" do
			game = GameBoard.new
			game.place_pieces
			game.update_possible_moves
			#game.positions[0][4].find_possible_moves(game.positions)
			expect( game.positions[0][4].possible_moves ).not_to include([1,4])
		end
	end
end