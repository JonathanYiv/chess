require_relative 'string.rb'

# Players have a name and prompt for sanitized move input.
class Player
  def initialize(number)
    @name = get_name(number)
  end

  def to_s
    @name.bold
  end

  def get_name(number)
    print "Hello Player #{number}! What is your name?\n> "
    @name = gets.chomp
    puts ''
    @name
  end

  def get_move
    move = input
    until move_format =~ move
      print "\nThat doesn't appear to be in the correct format. Remember: [Letter][Number] to [Letter][Number].\n> "
      move = input
    end
    move_format.match(move)
  end

  private

  def move_format
    /^([a-h])([1-8])\s{1}to\s{1}([a-h])([1-8])$/
  end

  def input
    gets.chomp.downcase
  end
end
