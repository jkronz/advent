class DayFifteen

  def self.discs
    [Disc.new(13, 10, 1),
     Disc.new(17, 15, 2),
     Disc.new(19, 17, 3),
     Disc.new(7, 1, 4),
     Disc.new(5, 0, 5),
     Disc.new(3, 1, 6)]
  end

  def self.two
    discs + [Disc.new(11, 0, 7)]
  end

  def self.example
    [Disc.new(5, 4, 1), Disc.new(2, 1, 2)]
  end

  def initialize(discs)
    @discs = discs
    @current_time = 0
  end

  def find_drop
    until @discs.all? { |disc| disc.current == 0 }
      @current_time += 1
      @discs.each { |d| d.increment }
    end
    @current_time
  end

  class Disc
    attr_accessor :current

    def initialize(positions, current, n)
      @max = positions - 1
      @current = current
      @n = n
      n.times { increment }
    end

    def increment
      @current += 1
      if @current > @max
        @current = 0
      end
    end

    def current
      @current
    end
  end
end