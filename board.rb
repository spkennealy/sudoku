class String
    def red;            "\e[31m#{self}\e[0m" end
    def yellow;         "\e[1;33m#{self}\e[0m" end
    def bold;           "\e[1m#{self}\e[21m" end
    def underline;      "\e[4m#{self}\e[24m" end
end

require_relative "tile"

class Board

    attr_reader :grid

    def initialize(file)
        @grid = Board.from_file(file)
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

    def [](pos)
        @grid[pos[0]][pos[1]].value
    end

    def []=(pos, input_value)
        @grid[pos[0]][pos[1]].value = input_value
    end

    def render
        puts ""
        puts "                         S U D O K U".bold.red
        puts "  == 1 === 2 === 3 === 4 === 5 === 6 === 7 === 8 === 9 ==".bold.red

        @grid.each_with_index do |row, row_idx|
            if row_idx % 3 == 0 && row_idx != 0
                puts "  ======================================================="
                print "#{row_idx + 1}".bold.red
            else
                print "#{row_idx + 1}".bold.red
            end 
            row.each_with_index do |tile, tile_idx|
                if tile.value > 0
                    if tile_idx % 3 == 0 || tile_idx == row.length
                        print " | ".bold
                    else 
                        print " : "
                    end
                    
                    if tile.show
                        print " #{tile.value} ".yellow
                    else 
                        print " #{tile.value} "
                    end 
                else
                    if tile_idx % 3 == 0 || tile_idx == row.length
                        print " | ".bold
                    else 
                        print " : "
                    end
                    print "   "
                end 
            end
            puts " | ".bold
        end 
        puts " ======================================================="
    end 

    def solved?
        solved_all_rows? && solved_all_rows? && solved_all_squares?
    end 

    def solved_all_rows?
        @grid.all? do |row|
            ordered_row = []
            row.each do |tile|
                ordered_row << tile.value
            end 
            ordered_row.sort == [1, 2, 3, 4, 5, 6, 7, 8, 9]
        end 
    end 

    def solved_all_columns?
        transposed = @grid.transpose
        transposed.all? do |row|
            ordered_column = []
            row.each do |tile|
                ordered_column << tile.value
            end 
            ordered_column.sort == (1..9).to_a
        end 
    end 

    def solved_all_squares?
        left_squares_array = []
        middle_squares_array = []
        right_squares_array = []

        @grid.each_with_index do |row, row_idx|
            
            row.each_with_index do |tile, col_idx|
                if col_idx < 3 
                    left_squares_array << tile.value
                elsif col_idx > 2 && col_idx < 6
                    middle_squares_array << tile.value
                else
                    right_squares_array << tile.value 
                end
            end
        end 

        squares_array = [
            left_squares_array[0..8], 
            left_squares_array[9..17],
            left_squares_array[18..26],
            middle_squares_array[0..8],
            middle_squares_array[9..17],
            middle_squares_array[18..26],
            right_squares_array[0..8],
            right_squares_array[9..17],
            right_squares_array[18..26]
        ]
        
        squares_array.all? do |square|
            square.sort == (1..9).to_a
        end 
        
    end 
end
