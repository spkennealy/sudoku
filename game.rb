require_relative "board"

class Game
    
    attr_reader :board

    def initialize
        @board = nil
    end 

    def start
        sudokus = {
            1 => "puzzles/sudoku1.txt",
            2 => "puzzles/sudoku2.txt",
            3 =>  "puzzles/sudoku3.txt",
            4 => "puzzles/sudoku1_almost.txt",
            5 => "puzzles/sudoku1_solved.txt"
        }
        
        system("clear")
        puts "Want to play Sudoku????"
        puts "Pick a puzzle: 1, 2, or 3"
        sudoku = gets.chomp.to_i
        @board = Board.new(sudokus[sudoku])
        @board.render
        play
    end

    def play
        until @board.solved?
            prompt
        end

        puts ""
        puts "CONGRATULATIONS!!! YOU SOLVED IT!!!".bold.underline
        puts ""
        puts "🎊🎉🎉🎉🥳🥳🥳🎉🎉🎉🎊"
    end 

    def prompt
        puts "Please enter a position with row and column (ex. 1 2):"
        pos = gets.chomp.split(" ").map {|num_string| num_string.to_i - 1}
        if pos.length != 2
            puts "Sorry, invalid entry."
            prompt
        end
        puts "Please enter the value for that position:"
        value = gets.chomp.to_i

        self.add_number(pos, value)
        system("clear")
        board.render
    end

    def [](pos)
        @board[pos[0]][pos[1]]
    end 

    def []=(pos, value)
        @board[pos[0]][pos[1]] = value
    end 

    def add_number(pos, value)
        if @board[pos] > 0
            puts "Sorry, you can't change that location."
            prompt
        else 
            @board[pos] = value
        end 
    end 
end 

if __FILE__ == $PROGRAM_NAME
    game1 = Game.new 
    game1.start
end 