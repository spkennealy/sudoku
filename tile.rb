require 'colorize'

class Tile

    attr_reader :value

    def initialize(value)
        @value = value
        @show = false
        @show = true if value > 0
    end 

    def to_s
        " #{@value} "
    end 

    def hide
        @show = false
    end

    def show
        @show = true
    end 
end 
