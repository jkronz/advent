class Game
  def initialize(starting)
    @memory = {}
    starting.each_with_index do |num, idx|
      @memory[num] = [idx]
    end
    @turn = starting.count
    @current = starting.last
  end

  def incr
    previous_said_times = Array(@memory[@current])
    if previous_said_times.count < 2
      @current = 0
    else
      @current = previous_said_times[0] - previous_said_times[1]
    end
    @memory[@current] = [@turn, Array(@memory[@current])[0]].compact
    @turn += 1
  end

  def to_s
    "#{@turn + 1}: #{@current}"
  end

  def play(iterations: 2020)
    loop do
      incr
      break if @turn == iterations
    end
    @current
  end
end

puts Game.new([8,11,0,19,1,2]).play(iterations: 30_000_000)
