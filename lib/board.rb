# frozen_string_literal: true
require_relative 'pieces/piece.rb'
require_relative 'pieces/knight.rb'
require_relative 'pieces/queen.rb'
require_relative 'pieces/rook.rb'
require_relative 'pieces/bishop.rb'
require_relative 'pieces/king.rb'
require_relative 'pieces/pawn.rb'

# Class which places pieces on the board, tracks them in a positions array, and draws the board
class Board
  attr_accessor :positions

  def initialize
    # Initialize the board, which is an 8 x 8 array of nil elements before placing pieces
    @positions = Array.new(8) { Array.new(8, nil) }
  end

  def fill_board
    place_white_backline
    place_black_backline
    place_pawns
  end

  def place_white_backline
    @positions[7][0] = Rook.new(true, [7, 0])
    @positions[7][1] = Knight.new(true, [7, 1])
    @positions[7][2] = Bishop.new(true, [7, 2])
    @positions[7][3] = Queen.new(true, [7, 3])
    @positions[7][4] = King.new(true, [7, 4])
    @positions[7][5] = Bishop.new(true, [7, 5])
    @positions[7][6] = Knight.new(true, [7, 6])
    @positions[7][7] = Rook.new(true, [7, 7])
  end

  def place_black_backline
    @positions[0][0] = Rook.new(false, [0, 0])
    @positions[0][1] = Knight.new(false, [0, 1])
    @positions[0][2] = Bishop.new(false, [0, 2])
    @positions[0][3] = Queen.new(false, [0, 3])
    @positions[0][4] = King.new(false, [0, 4])
    @positions[0][5] = Bishop.new(false, [0, 5])
    @positions[0][6] = Knight.new(false, [0, 6])
    @positions[0][7] = Rook.new(false, [0, 7])
  end

  def place_pawns
    (0..7).each do |num|
      @positions[6][num] = Pawn.new(true, [6, num])
      @positions[1][num] = Pawn.new(false, [1, num])
    end
  end

  def display_top_border
    puts "\n"
    puts '    ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐'
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
    print " #{9 - number}  "
    @positions[number - 1].each do |position|
      if position.nil?
        print square.even? ? '│     ' : "│#{'     '}"
      else
        print square.even? ? "│  #{position.icon}  " : "│#{"  #{position.icon}  "}"
      end
      square += 1
    end
    puts '│'
  end

  def display_separator
    puts '    ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤'
  end

  def display_bottom_border
    puts '    └─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘'
  end

  def display_x_axis
    puts "       A     B     C     D     E     F     G     H  \n\n"
  end

  def logo
    puts  '              _'
    puts  '             | |                            __'
    puts  '          ___| |__   ___  ___ ___          (  )'
    puts  '         / __| \'_ \\ / _ \\/ __/ __|          ||'
    puts  '        | (__| | | |  __/\\__ \\__ \\         /__\\'
    puts  '         \\___|_| |_|\\___||___/___/        (____)'
  end


  def display
    display_top_border
    display_rows
    display_bottom_border
    display_x_axis
  end
end