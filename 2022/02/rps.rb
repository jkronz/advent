class Game  
  # A X Rock  1
  # B Y Paper 2
  # C Z Sci   3  
  def initialize(line)
    @left, @result = line.split(' ')  
    @right = case @left
    when 'A' # ROCK
      case @result
      when 'X' # LOSE
        'Z'
      when 'Y' # DRAW
        'X'
      when 'Z' # WIN
        'Y'
      end
    when 'B' # PAPER
      case @result
      when 'X' # LOSE
        'X'
      when 'Y' # DRAW
        'Y'
      when 'Z' # WIN
        'Z'
      end
    when 'C' # SCISSORS
      case @result
      when 'X' # LOSE
        'Y'
      when 'Y' # DRAW
        'Z'
      when 'Z' # WIN
        'X'
      end
    end
  end

  def wld
    case @left
    when 'A' # ROCK
      case @right
      when 'X' # ROCK
        3
      when 'Y' # PAPER
        6
      when 'Z' # SCISSORS
        0
      end
    when 'B' # PAPER
      case @right
      when 'X' # ROCK
        0
      when 'Y' # PAPER
        3
      when 'Z' # SCISSORS
        6
      end
    when 'C' # SCISSORS
      case @right
      when 'X' # ROCK
        6
      when 'Y' # PAPER
        0
      when 'Z' # SCISSORS
        3
      end
    end
  end

  def score
    score = wld
    score += case @right    
    when 'X' # 1 Rock
      1      
    when 'Y' # 2 
      2
    when 'Z' # 3 
      3
    end
  end

  def to_s
    "#{@left}, #{@right}: #{wld} #{score}"
  end
end

score = 0
File.readlines('input.txt').each do |line|
  puts g = Game.new(line)
  score += g.score  
end
puts score  