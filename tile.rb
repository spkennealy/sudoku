class Tile

    attr_accessor :value, :show

    def initialize(value)
        @value = value
        value > 0 ? @show = true : @show = false
    end 

    def to_s
        " #{@value} "
    end 
end 
