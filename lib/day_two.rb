class DayTwo
  ONE = [['1', '2', '3'],
         ['4', '5', '6'],
         ['7', '8', '9']]
  TWO = [[nil, nil, '1', nil, nil],
         [nil, '2', '3', '4', nil],
         ['5', '6', '7', '8', '9'],
         [nil, 'A', 'B', 'C', nil],
         [nil, nil, 'D', nil, nil]]

  def initialize
    @code = []
  end

  def parse_input(input, keypad=ONE, current_pos=[1, 1])
    input.gsub(/\s+/, ' ')
    @current_pos = current_pos
    input.split(' ').each do |line|
      @code << parse_line(line.gsub(' ', ''), keypad)
    end
    @code.join
  end

  def parse_line(line, keypad)
    line.chars.each do |character|
      send("move_#{character}", keypad)
    end
    keypad[@current_pos[0]][@current_pos[1]]
  end

  def move_L(keypad)
    row, column = @current_pos
    column = column - 1
    return if column == -1 || keypad[row][column].nil?
    @current_pos = [row, column]
  end

  def move_R(keypad)
    row, column = @current_pos
    column = column + 1
    return if column >= keypad[row].length || keypad[row][column].nil?
    @current_pos = [row, column]
  end

  def move_D(keypad)
    row, column = @current_pos
    row = row + 1
    return if row >= keypad.length || keypad[row][column].nil?
    @current_pos = [row, column]
  end

  def move_U(keypad)
    row, column = @current_pos
    row = row - 1
    return if row == -1 || keypad[row][column].nil?
    @current_pos = [row, column]
  end

end
