require 'pry'
class Seat
  def initialize(input)
    @row_ident = input[0, 7]
    @column_ident = input[7, 3]
  end

  def row
    bin = @row_ident.gsub('F', '0').gsub('B', '1')
    bin.to_i(2)
  end

  def column
    bin = @column_ident.gsub('L', '0').gsub('R', '1')
    bin.to_i(2)
  end

  def id
    row * 8 + column
  end
end

class Scanner
  def initialize(file)
    seat_strings = File.readlines(file, chomp: true)
    @seats = seat_strings.map { |str| Seat.new(str) }
  end

  def find_max
    seat = @seats.max_by(&:id)
    seat.id
  end

  def find_empty
    ids = @seats.map(&:id).sort
    ids.each_with_index do |id, i|
      puts id if ids[i + 1] != id + 1
    end
  end
end
# puts Seat.new('FBFBBFFRLR').id
# puts Seat.new('BFFFBBFRRR').id
# puts Seat.new('FFFBBBFRRR').id
# puts Seat.new('BBFFBBFRLL').id

puts Scanner.new('input.txt').find_max
Scanner.new('input.txt').find_empty
