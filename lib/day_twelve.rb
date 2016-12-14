require 'input_reader'
class DayTwelve
  include InputReader

  def initialize(file='input/day_twelve.txt')
    @instructions = read_rows(file)
    @register = { 'a' => 0, 'b' => 0, 'c' => 1, 'd' => 0 }
    @current_line = 0
  end

  def execute
    while @current_line < @instructions.count
      instruction = parse(@instructions[@current_line])
      send(instruction[:operator], instruction[:left], instruction[:right])
    end
    puts "Output #{@register}"
    @register
  end

  def cpy(left, right)
    @register[right] = value(left)
    @current_line += 1
  end

  def inc(left, _)
    @register[left] += 1
    @current_line+= 1
  end

  def dec(left, _)
    @register[left] -= 1
    @current_line += 1
  end

  def jnz(cond, address)
    if value(cond) > 0
      @current_line += address.to_i
    else
      @current_line += 1
    end
  end

  def value(left)
    left.to_i == 0 ? @register[left].to_i : left.to_i
  end

  PARSER = /(cpy|inc|dec|jnz) ([a-d\-\d]+) ?([a-d\-\d]*)/.freeze

  def parse(line)
    match = PARSER.match(line)
    {
      operator: match[1],
      left: match[2],
      right: match[3]
    }
  end

end