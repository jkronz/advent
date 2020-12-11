def seat_factory(char)
  if char == '.'
    Floor.new
  else
    Chair.new(char)
  end
end

class Floor
  def open?
    false
  end

  def occupied?
    false
  end

  def to_s
    '.'
  end

  def toggle
    # noop
  end
end

class Chair
  def initialize(char)
    @state = char
    @marked = false
  end

  def open?
    @state == 'L'
  end

  def occupied?
    @state == '#'
  end

  def mark
    @marked = true
  end

  def toggle
    return unless @marked
    @marked = false
    @state = occupied? ? 'L' : '#'
  end

  def to_s
    @state
  end
end

class WaitingRoom
  attr_reader :rows

  def initialize(file)
    lines = File.readlines(file, chomp: true)
    @rows = []
    lines.each_index do |idx|
      @rows[idx] = lines[idx].chars.map { |chr| seat_factory(chr) }
    end
    @width = @rows.first.length
    @height = @rows.length
  end

  def to_s
    @rows.map do |row|
      row.map(&:to_s).join
    end.join("\n") + "\n\n"
  end

  def organize
    loop do
      occupied, marked = analyze
      return occupied if marked.zero?
      toggle
      # puts to_s
    end
  end

  def analyze
    occupied = 0
    marked = 0
    @rows.each_index do |row|
      @rows[row].each_index do |column|
        marked += analyze_position(row, column)
        occupied += 1 if @rows[row][column].occupied?
      end
    end
    [occupied, marked]
  end

  def toggle
    @rows.each do |row|
      row.each(&:toggle)
    end
  end

  def analyze_position(row, column)
    adjacent_occupied = 0
    (row - 1..row + 1).each do |y|
      (column - 1..column + 1).each do |x|
        next if x == column && y == row
        next if x < 0 || y < 0 || y >= @rows.length || x >= @rows[0].length
        seat = @rows[y][x]
        adjacent_occupied += 1 if !seat.nil? && seat.occupied?
      end
    end
    seat = @rows[row][column]
    if seat.open? && adjacent_occupied == 0
      seat.mark
      1
    elsif seat.occupied? && adjacent_occupied >= 4
      seat.mark
      1
    else
      0
    end
  end

  def look(row, col, direction)
    key = "#{row},#{col},#{direction}"
    return 0 if row.negative? || row == @height || col.negative? || col == @width

    case direction
    when 'N'
      return 0 if row == 0
      return 1 if @rows.dig(row - 1, col)&.occupied?
      return 0 if @rows.dig(row - 1, col)&.open?
      look(row - 1, col, 'N')
    when 'S'
      return 0 if row + 1 == @height
      return 1 if @rows.dig(row + 1, col)&.occupied?
      return 0 if @rows.dig(row + 1, col)&.open?
      look(row + 1, col, 'S')
    when 'E'
      return 0 if col + 1 == @width
      return 1 if @rows.dig(row, col + 1)&.occupied?
      return 0 if @rows.dig(row, col + 1)&.open?
      look(row, col + 1, 'E')
    when 'W'
      return 0 if col == 0
      return 1 if @rows.dig(row, col - 1)&.occupied?
      return 0 if @rows.dig(row, col - 1)&.open?
      look(row, col - 1, 'W')
    when 'NE'
      return 0 if row == 0 || col + 1 == @width
      return 1 if @rows.dig(row - 1, col + 1)&.occupied?
      return 0 if @rows.dig(row - 1, col + 1)&.open?
      look(row - 1, col + 1, 'NE')
    when 'NW'
      return 0 if row == 0 || col == 0
      return 1 if @rows.dig(row - 1, col - 1)&.occupied?
      return 0 if @rows.dig(row - 1, col - 1)&.open?
      look(row - 1, col - 1, 'NW')
    when 'SE'
      return 0 if row == @height || col + 1 == @width
      return 1 if @rows.dig(row + 1, col + 1)&.occupied?
      return 0 if @rows.dig(row + 1, col + 1)&.open?
      look(row + 1, col + 1, 'SE')
    when 'SW'
      return 0 if row == @height || col == 0
      return 1 if @rows.dig(row + 1, col - 1)&.occupied?
      return 0 if @rows.dig(row + 1, col - 1)&.open?
      look(row + 1, col - 1, 'SW')
    end
  end

  def surrounding_chairs(row, col)
    look(row, col, 'N') +
      look(row, col, 'S') +
      look(row, col, 'E') +
      look(row, col, 'W') +
      look(row, col, 'NE') +
      look(row, col, 'NW') +
      look(row, col, 'SE') +
      look(row, col, 'SW')
  end

  def organize_p2
    loop do
      occupied, marked = analyze_p2
      return occupied if marked.zero?
      toggle
    end
  end

  def analyze_p2
    occupied = 0
    marked = 0
    @rows.each_index do |row|
      @rows[row].each_index do |column|
        marked += analyze_seat_p2(row, column)
        occupied += 1 if @rows[row][column].occupied?
      end
    end
    [occupied, marked]
  end

  def analyze_seat_p2(row, col)
    adjacent_occupied = surrounding_chairs(row, col)
    seat = @rows[row][col]
    if seat.open? && adjacent_occupied == 0
      seat.mark
      1
    elsif seat.occupied? && adjacent_occupied >= 5
      seat.mark
      1
    else
      0
    end
  end
end

puts WaitingRoom.new('input.txt').organize_p2
