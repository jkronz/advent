require 'input_reader'
class DayThree
  include InputReader

  def initialize
    @vertices = read_rows('input/day_three.txt').each_with_object([]) do |row, accum|
      accum << row.split(' ').map(&:to_i)
    end.flatten
  end

  def process(part_two = false)
    count = 0
    if part_two
      @vertices.each_slice(9) do |rows|
        count += 1 if process_row([rows[0], rows[3], rows[6]])
        count += 1 if process_row([rows[1], rows[4], rows[7]])
        count += 1 if process_row([rows[2], rows[5], rows[8]])
      end
    else
      @vertices.each_slice(3) do |row|
        count += 1 if process_row(row)
      end
    end
    count
  end

  def process_row(row)
    row.sort!
    (row[0] + row[1]) > row[2]
  end

end