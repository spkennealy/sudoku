require_relative "tile.rb"

class Board

# A Board should store a grid of Tiles. Define your Board#initialize method 
# to accept such a grid as an argument. Since our puzzles exist as text files, 
# let's write a Board::from_file factory method to read a file and parse it 
# into a two-dimensional Array containing Tile instances.

    attr_reader :board

    def initialize(file)
        @board = Board.from_file(file)
    end

    def self.from_file(file)
        lines = File.readlines(file).map(&:chomp)
        tiled = []

        lines.each do |row|
            current_row_tiles = []
            array_of_digits = row.split("")
            array_of_digits.map do |num_string|
                current_row_tiles << Tile.new(num_string.to_i)
            end
            tiled << current_row_tiles
        end 
        
        tiled
    end

    # The Board class will be doing much of the heavy lifting for our game's 
    # logic. It will need the following methods:

    # A method to update the value of a Tile at the given position
    # A render method to display the current board state
    # A solved? method to let us know if the game is over
    # I used several helper methods here. You will want to know if each row, 
    # column, and 3x3 square has been solved.

    def [](pos)
        @board[pos[0]][pos[1]]
    end

    def []=(pos, value)
        @board[pos[0]][pos[1]] = value
    end

    def render
        puts ""
        puts " S U D O K U"
        @board.each_with_index do |row, row_idx|
            if row_idx % 3 == 0
                puts " ======================================================="
            end 
            row.each_with_index do |tile, tile_idx|
                if tile.value > 0
                    if tile_idx % 3 == 0 || tile_idx == row.length
                        print " | "
                    else 
                        print " : " 
                    end
                    print " #{tile.value} "
                else
                    if tile_idx % 3 == 0 || tile_idx == row.length
                        print " | "
                    else 
                        print " : " 
                    end
                    print "   "
                end 
            end
            puts " | "
        end 
        puts " ======================================================="
    end 

    def solved?

    end 
end


system("clear")
file = "puzzles/sudoku1.txt"
board1 = Board.new(file)
board1.render