# Board is responsible for knowing the state of the board, displaying itself, and utility functions
class Board
  attr_accessor :positions

  def initialize(testing = false)
    @positions = Array.new(8) { Array.new(8, nil) }
    place_pieces unless testing
  end

  def place_pieces
    place_white_row
    place_black_row
    place_pawns
  end

  def place_white_row
    @positions[7][0] = Rook.new([7, 0], true)
    @positions[7][1] = Knight.new([7, 1], true)
    @positions[7][2] = Bishop.new([7, 2], true)
    @positions[7][3] = Queen.new([7, 3], true)
    @positions[7][4] = King.new([7, 4], true)
    @positions[7][5] = Bishop.new([7, 5], true)
    @positions[7][6] = Knight.new([7, 6], true)
    @positions[7][7] = Rook.new([7, 7], true)
  end

  def place_black_row
    @positions[0][0] = Rook.new([0, 0], false)
    @positions[0][1] = Knight.new([0, 1], false)
    @positions[0][2] = Bishop.new([0, 2], false)
    @positions[0][3] = Queen.new([0, 3], false)
    @positions[0][4] = King.new([0, 4], false)
    @positions[0][5] = Bishop.new([0, 5], false)
    @positions[0][6] = Knight.new([0, 6], false)
    @positions[0][7] = Rook.new([0, 7], false)
  end

  def place_pawns
    place_white_pawns
    place_black_pawns
  end

  def place_white_pawns
    0.upto(7) do |x|
      @positions[6][x] = Pawn.new([6, x], true)
    end
  end

  def place_black_pawns
    0.upto(7) do |x|
      @positions[1][x] = Pawn.new([1, x], false)
    end
  end

  def display
    clear
    ChessText.title
    display_top_border
    display_rows
    display_bottom_border
    display_x_axis
  end

  def clear
    system 'clear'
    system 'cls'
  end

  def display_top_border
    puts '   ┌────┬────┬────┬────┬────┬────┬────┬────┐'
  end

  def display_rows
    (1..7).each do |row_number|
      display_row(row_number)
      display_separator
    end
    display_row(8)
  end

  def display_row(number)
    square = number.even? ? 0 : 1
    print "#{number}  "
    @positions[number - 1].each do |position|
      if position.nil?
        print square.even? ? '│    ' : "│#{'    '.bg_black}"
      else
        print square.even? ? "│ #{position.icon}  " : "│#{" #{position.icon}  ".bg_black}"
      end
      square += 1
    end
    puts '│'
  end

  def display_separator
    puts '   ├────┼────┼────┼────┼────┼────┼────┼────┤'
  end

  def display_bottom_border
    puts '   └────┴────┴────┴────┴────┴────┴────┴────┘'
  end

  def display_x_axis
    puts "     a    b    c    d    e    f    g    h  \n\n"
  end

  def self.clone(positions)
    cache = Array.new(8) { Array.new(8, nil) }
    0.upto(7) do |x|
      0.upto(7) do |y|
        original = positions[x][y]
        copy = original.nil? ? nil : original.class.new([x, y], original.color == 'white')
        cache[x][y] = copy
        if original.instance_of?(King) || original.instance_of?(Pawn) || original.instance_of?(Rook)
          copy.has_moved = original.has_moved
          copy.double_stepped = original.double_stepped if original.instance_of?(Pawn)
        end
      end
    end
    cache
  end

  def self.includes?(x, y)
    within_seven?(x) && within_seven?(y)
  end

  def self.within_seven?(number)
    (0..7).cover?(number)
  end
end
