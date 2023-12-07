class Schematic
  def initialize(filename)
    @grid = File.readlines(filename)
  end

  NUMBER_MATCH = /(\d+)/.freeze
  SYMBOL_MATCH = /[^\d\.]/.freeze
  def part_numbers
    return @part_numbers unless @part_numbers.nil?
    @part_numbers = []
    @grid.each_with_index do |line, row|
      current_index = 0
      loop do
        puts row
        puts "Cur #{current_index}"
        md = line.match(NUMBER_MATCH, current_index)
        break if md.nil?
        value = md[0]
        head = line.index(value, current_index)
        tail = head + value.length
        puts "val #{value}"
        puts "tail #{tail}"
        value = value.to_i
        range = head...tail
        if adjacent_symbol?(row, range)
          @part_numbers << value
        else
          puts "#{value} no good"
        end
        current_index = tail + 1
      end
    end
    @part_numbers
  end

  def adjacent_symbol?(row, range)
    adjacent_match?(row, range, SYMBOL_MATCH)
  end

  def adjacent_match?(row, range, pattern)
    st = [range.first - 1, 0].max
    ed = [range.last + 1, @grid[row].length - 1].min
    if row > 0
      current_line = @grid[row - 1]
      return true if current_line[st...ed].match?(pattern)
    end
    if row != @grid.length - 1
      current_line = @grid[row + 1]
      return true if current_line[st...ed].match?(pattern)
    end
    current_line = @grid[row]
    current_line[st...ed].match?(pattern)
  end
  def adjacent_part_number?(row, range)

  end
  def gears

  end
end

puts Schematic.new(__dir__ + '/input.txt').part_numbers.sum