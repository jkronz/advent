class DayEighteen
  def self.input
    '^^.^..^.....^..^..^^...^^.^....^^^.^.^^....^.^^^...^^^^.^^^^.^..^^^^.^^.^.^.^.^.^^...^^..^^^..^.^^^^'
  end

  def self.example
    '.^^.^.^^^^'
  end

  def initialize(input = DayEighteen.input)
    @current_row = input.chars
    @width = input.chars.length
    @y = 0
    @x = 0
  end

  def count_safes(rows)
    count = count_row
    @y = 1
    until @y == rows
      @previous_row = @current_row
      fill_row
      count += count_row
      @y += 1
    end
    count
  end

  def count_row
    @current_row.count { |c| c == '.' }
  end

  def fill_row
    @current_row = []
    (0...@width).each do |i|
      @x = i
      @current_row[@x] = fill_item
    end
  end

  def fill_item
    return '^' if left == '^' && center == '^' && right == '.'
    return '^' if left == '.' && center == '^' && right == '^'
    return '^' if left == '^' && center == '.' && right == '.'
    return '^' if left == '.' && center == '.' && right == '^'
    return '.'
  end

  def left
    if @x == 0
      '.'
    else
      @previous_row[@x - 1]
    end
  end

  def center
    @previous_row[@x]
  end

  def right
    if @x == (@width - 1)
      '.'
    else
      @previous_row[@x + 1]
    end
  end

end