class Game

    def initialize
        @board
    end 

    def play
        #runs until the board is solved
    end 

    def render

    end 

    def prompt(pos, value)

    end

    def [](pos)
        @board[pos[0]][pos[1]]
    end 

    def []=(pos, value)
        @board[pos[0]][pos[1]] = value
    end 

    def get_input

    end 

    def validate?

    end
end 