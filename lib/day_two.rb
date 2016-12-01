class DayOne
  TOP = [1, 2, 3]
  BOTTOM = [7, 8, 9]
  LEFT = [1, 4, 7]
  RIGHT = [3, 6, 9]

  def initialize
    @current_pos = 5
    @code = []
  end

  def parse_input(input)
    input.split('\n').each do |line|
      @code << parse_line(line.gsub(' ', ''))
    end
    @code.join('')
  end

  def parse_line(line)
    line.chars.each do |character|
      send("move_#{character}")
    end
    @current_pos
  end

  def move_L
    return if LEFT.include?(@current_pos)
    @current_pos = @current_pos - 1
  end

  def move_R
    return if RIGHT.include?(@current_pos)
    @current_pos = @current_pos + 1
  end

  def move_D
    return if BOTTOM.include?(@current_pos)
    @current_pos = @current_pos + 3
  end

  def move_U
    return if TOP.include?(@current_pos)
    @current_pos = @current_pos - 3
  end

end
